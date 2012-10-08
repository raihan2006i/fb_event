ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "www.nascenia.com",
  :user_name => "do-not-reply@nascenia.com",
  :password => "12nascenia3",
  :authentication => "plain",
  :enable_starttls_auto => true
}
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?