class AuthenticationsController < ApplicationController
#  def index
#    @authentications = current_user.authentications if current_user
#  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(filter_provider(omniauth['provider']), omniauth['uid'])
    if authentication
      authentication.update_attributes({:token => omniauth['credentials']['token'], :secret => omniauth['credentials']['secret']})
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.apply_omniauth(omniauth)
      current_user.save(:validate => false)
      flash[:notice] = "Authentication successful."
      redirect_to profile_user_path(current_user)
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save(:validate => false)
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

#  def destroy
#    @authentication = current_user.authentications.find(params[:id])
#    @authentication.destroy
#    flash[:notice] = "Successfully destroyed authentication."
#    redirect_to authentications_url
#  end

  protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end

  def filter_provider(provider)
    if provider == 'google_oauth2'
      "google"
    else
      provider
    end
  end
 
end
