module UsersHelper
  def get_social_icon(account_type, account_name)
    if(account_type == SocialAccount::TYPE_LINKEDIN)
      return link_to(image_tag("linkedin.png", :class => "menu_icon"), "http://www.linkedin.com/#{account_name}", :target => '_blank')
    elsif(account_type == SocialAccount::TYPE_TWITTER)
      return link_to(image_tag("twitter.png", :class => "menu_icon"), "http://www.twitter.com/#{account_name}", :target => '_blank')
    elsif(account_type == SocialAccount::TYPE_FACEBOOK)
      return link_to(image_tag("facebook.png", :class => "menu_icon"), "http://www.facebook.com/#{account_name}", :target => '_blank')
    elsif(account_type == SocialAccount::TYPE_FOURSQUARE)
      return link_to(image_tag("foursquare.png", :class => "menu_icon"), "https://foursquare.com/#{account_name}", :target => '_blank')
    elsif(account_type == SocialAccount::TYPE_GOOGLE)
      return link_to(image_tag("google_32.png", :class => "menu_icon"), "https://plus.google.com/#{account_name}", :target => '_blank')
    end
  end
  
end


