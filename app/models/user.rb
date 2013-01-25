class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :social_accounts, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :profession, :first_name, :last_name
  attr_accessible :social_accounts_attributes
  attr_accessor :social_account_name, :social_account_type

  accepts_nested_attributes_for :social_accounts, :allow_destroy => true
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :username, :presence => true
  validates :username, :uniqueness => true
  
  after_create :create_profile

  def apply_omniauth(omniauth)
    #puts omniauth.inspect
    if omniauth['info']
      self.email = omniauth['info']['email']
      self.first_name = omniauth['info']['first_name'] || (omniauth['info']['name'].split(" ", 2).first rescue "")
      self.last_name = omniauth['info']['last_name'] || (omniauth['info']['name'].split(" ", 2).last  rescue "")
    end
    authentications.build(:provider => filter_provider(omniauth['provider']), :uid => omniauth['uid'], :token => omniauth['credentials']['token'], :secret => omniauth['credentials']['secret'], :account_name => filter_account_name(omniauth))
    social_accounts.build(:account_type => SocialAccount::ACCOUNT_TYPES[filter_provider(omniauth['provider']).to_sym], :account_name => filter_account_name(omniauth))
    self.confirmed_at = DateTime.now
  end

  def name
    "#{first_name} #{last_name}"
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def post_tweet(message)
    Twitter.configure do |config|
      config.consumer_key = OMNIAUTH_CONFIG["twitter"]["key"]
      config.consumer_secret = OMNIAUTH_CONFIG["twitter"]["secret"]
      config.oauth_token = twitter_account.token
      config.oauth_token_secret = twitter_account.secret
    end
    client = Twitter::Client.new
    begin
      client.update(message)
      return true
    rescue Exception => e
      self.errors.add(:oauth_token, "Unable to send to twitter: #{e.to_s}")
      return false
    end
  end

  def facebook_account
    if @facebook_account.nil?
      @facebook_account = authentications.find_by_provider("facebook")
    end
    @facebook_account
  end

  def twitter_account
    if @twitter_account.nil?
      @twitter_account = authentications.find_by_provider("twitter")
    end
    @twitter_account
  end

  def has_facebook?
    if @facebook_account.nil?
      @facebook_account = authentications.find_by_provider("facebook")
    end
    @facebook_account.present?
  end

  def has_twitter?
    if @twitter_account.nil?
      @twitter_account = authentications.find_by_provider("twitter")
    end
    @twitter_account.present?
  end

  private
  def create_profile
    profile = self.build_profile({:display_name => name })
    profile.save(:validate => false)
  end

  def filter_provider(provider)
    if provider == 'google_oauth2'
      "google"
    else
      provider
    end
  end

  def filter_account_name(omniauth)
    if omniauth['provider'] == 'google_oauth2'
      omniauth['uid']
    else
      omniauth['info']['nickname']
    end
  end


end
