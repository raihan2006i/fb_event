require 'openid/store/filesystem'
OMNIAUTH_CONFIG = YAML.load_file("#{Rails.root}/config/omniauth.yml")[Rails.env]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, OMNIAUTH_CONFIG["twitter"]["key"], OMNIAUTH_CONFIG["twitter"]["secret"]
  provider :facebook,OMNIAUTH_CONFIG["facebook"]["key"], OMNIAUTH_CONFIG["facebook"]["secret"], {:scope => OMNIAUTH_CONFIG["facebook"]["scope"]}
  provider :google_oauth2, OMNIAUTH_CONFIG["google"]["key"], OMNIAUTH_CONFIG["google"]["secret"], {}
end
