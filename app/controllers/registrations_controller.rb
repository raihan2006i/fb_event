class RegistrationsController < Devise::RegistrationsController
  def new
    resource = build_resource({})
    if(params[:k])
      recommendation = Recommendation.find_by_signup_key(params[:k])
      if recommendation.present?
        resource.email = recommendation.recommender_email
        resource.social_account_name = recommendation.recommender_social_account_name
        resource.social_account_type = recommendation.recommender_social_account_type
      end
    end
    session[:omniauth] = nil
    respond_with resource
  end

  def create
    k = params[:user].delete(:k)
    build_resource
    if resource.save
      if(k)
        recommendation = Recommendation.find_by_signup_key(k)
        if recommendation
          recommendation.recommender = resource
          recommendation.save(:validate => false)
          if recommendation.recommender
            notification = recommendation.recommender.notifications.build
            notification.recommendation = recommendation
            notification.user = recommendation.recommender
            notification.notification_type = Notification::TYPE_REQUESTED
            notification.message = "#{recommendation.recommendee.profile.display_name} requested you for a Recommendation!"
            notification.save(:validate => false)
          end
        end
      end
      
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end

    else
      clean_up_passwords resource
      respond_with resource
    end
    session[:omniauth] = nil unless @user.new_record?
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end