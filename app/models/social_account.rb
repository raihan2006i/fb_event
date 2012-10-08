class SocialAccount < ActiveRecord::Base
  require "net/http"
  require "uri"
  require 'open-uri'

  belongs_to :user
  
  TYPE_LINKEDIN = 1
  TYPE_TWITTER = 2
  TYPE_FACEBOOK = 3
  TYPE_FOURSQUARE = 4
  TYPE_GOOGLE = 5

  ACCOUNT_TYPES = {
    :linkedin => TYPE_LINKEDIN,
    :twitter => TYPE_TWITTER,
    :facebook => TYPE_FACEBOOK,
    :foursquare => TYPE_FOURSQUARE,
    :google => TYPE_GOOGLE
  }

  attr_accessible :account_name, :account_type
  
  validates :account_name, :presence => true, :if => :must_be_valid_account
  validates :account_type, :presence => true

  def must_be_valid_account
    account_name = self.account_name
    account_type = self.account_type
    
    if (account_name && account_type == TYPE_FACEBOOK)
      uri = URI.parse("https://graph.facebook.com/#{account_name}")
      is_exist = check_profile(uri, TYPE_FACEBOOK)
      if(is_exist)
        return true
      else
        errors.add(:account_name, "is not a real facebook account!")
      end
    end

    if (account_name && account_type == TYPE_TWITTER)
      uri = URI.parse("https://api.twitter.com/1/users/show.json?screen_name=#{account_name}&include_entities=true")
      is_exist = check_profile(uri, TYPE_TWITTER)
      if(is_exist)
        return true
      else
        errors.add(:account_name, "is not a real twitter account!")
      end
    end

    if (account_name && account_type == TYPE_LINKEDIN)
      uri = URI.parse(account_name)
      is_exist = check_profile(uri, TYPE_LINKEDIN)
      if(is_exist)
        return true
      else
        errors.add(:account_name, "is not a real linkedin account! Please provide your linkedin public  profile url.")
      end
    end

    if (account_name && account_type == TYPE_GOOGLE)
      uri = URI.parse(account_name)
      is_exist = check_profile(uri, TYPE_GOOGLE)
      if(is_exist)
        return true
      else
        errors.add(:account_name, "is not a real google plus account! Please provide your google plus public  profile url.")
      end
    end

    if (account_name && account_type == TYPE_FOURSQUARE)
      uri = URI.parse(account_name)
      is_exist = check_profile(uri, TYPE_FOURSQUARE)
      if(is_exist)
        return true
      else
        errors.add(:account_name, "is not a real foursquare account! Please provide your foursquare public  profile url.")
      end
    end

  end


  def check_profile(uri, type)
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      if (type == TYPE_FACEBOOK || type == TYPE_TWITTER || type == TYPE_GOOGLE || type == TYPE_FOURSQUARE)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      
      if (type == TYPE_FACEBOOK || type == TYPE_TWITTER)
        response_value = JSON.parse(response.body)

        if(response_value["id"] != "" and response_value["id"])
          return true
        else
          return false
        end
      elsif (type == TYPE_LINKEDIN)
        doc = Nokogiri::HTML(response.body)
        page_title = doc.at_css("#page-title").try(:text)
        given_name = doc.at_css(".given-name").try(:text)
        family_name = doc.at_css(".family-name").try(:text)
        if (page_title && page_title =~ /profile not found/i)
          return false
        elsif (given_name || family_name)
          return true
        else
          return false
        end
      elsif (type == TYPE_GOOGLE)
        doc = Nokogiri::HTML(response.body)
        error_text1 = doc.css("p").first.try(:text)
        error_text2 = doc.css("p").last.try(:text)
        if ((error_text1 || error_text2) && (error_text1 =~ /404/i || error_text2 =~ /404/i)  && response.code.to_i == 404)
          return false
        else
          return true
        end
      elsif (type == TYPE_FOURSQUARE)
        doc = Nokogiri::HTML(response.body)
        error_text1 = doc.css("h1").first.try(:text)
        if (error_text1  && (error_text1 =~ /We couldn\'t find the page you're looking for./i)  && response.code.to_i == 404)
          return false
        else
          return true
        end
      end
    rescue Exception => ex
      return false
    end
  end
end
