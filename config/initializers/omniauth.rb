require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  if(Rails.env == 'development' || ['test', 'staging'].include?(Rails.env))
    #provider :twitter, 'xJEy6GxFCRND1srrjruA', 'UD6NhpUPgX1N2QN6y1w7Q8XZHYD1SzzNTmM2QDbEA'
    provider :facebook, '113236112165664', '90893ffc14ecdc7d911f04c1bcd23b6e', {:scope => "publish_stream,user_likes,email,offline_access,friends_photos, user_events, friends_events"}
    #provider :google_oauth2, "114480915958.apps.googleusercontent.com", "QXZQ9sFstcf_AeDKT3weG9rF", {}
  elsif(Rails.env == 'production')
    #provider :twitter, 'iFW7BK8SRIucf2YHUXfhmw', 'uE1zGXGf7Z6ozSok0pT2wUYstmVXI6YJl4V3WtsZg'
    provider :facebook, '113236112165664', '90893ffc14ecdc7d911f04c1bcd23b6e', {:scope => "publish_stream,user_likes,email,offline_access,friends_photos, user_events, friends_events"}
    #provider :google_oauth2, "146804609581.apps.googleusercontent.com", "TXX5gAQBfAXTzzxjesGHq3U0", {}
  end
end
