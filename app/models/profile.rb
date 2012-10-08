class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, :styles => { :medium => "300x300>", :small => "150x150>", :thumb => "100x100>" },
    :url  => "/assets/profile/:id/:style/:basename.:extension",
    :default_url => '/assets/pp-blank-thumb.png',
    :path => ":rails_root/public/assets/profile/:id/:style/:basename.:extension"


  validates_attachment_presence :photo, :unless => Proc.new { |imports| imports.photo_file_name.blank? }
  validates_attachment_size :photo, :less_than => 1.megabytes, :unless => Proc.new { |imports| imports.photo_file_name.blank? }
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif'], :message => "has to be in jpeg/png format", :unless => Proc.new { |imports| imports.photo_file_name.blank? }


  validates :display_name, :presence => { :message => "can't be blank" }
  validates_format_of :about_me, :with => /^[-\w]+(?:\W+[-\w]+){2}\W*$/i, :message => "should be only three words", :if => :about_me?


  accepts_nested_attributes_for :user, :allow_destroy => true
  attr_accessible :user_attributes, :display_name, :about_me, :email, :photo
  
end
