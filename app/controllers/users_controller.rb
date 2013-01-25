class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit_profile, :update_profile]
  before_filter :load_user
  before_filter :can_access, :only => [:edit_profile, :update_profile]
  before_filter :can_access_by_user, :only => [:edit_profile, :update_profile]
  # GET /users/1
  # GET /users/1.json
  def show
    #    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def update_profile
    #    @user = User.find_by_id(params[:id])
    @profile = @user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to profile_user_path(@user)
      return
    else
      render action: "edit_profile"
    end
  end

  def profile
    #    @user = User.find(params[:id])
    @profile = @user.profile
    
  end

  def events
    @fbuser = FbGraph::User.fetch(@user.authentications.first.account_name, :access_token => @user.authentications.first.token)
    @events = @fbuser.events
  end
  
  def edit_profile
    #    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def tweet
  end

  def post_tweet
    @user.post_tweet(params[:tweet])
    redirect_to profile_user_path(@user), :notice => "Your tweet has been posted"
  end

  private
  def load_user
    @user = User.find(params[:id])
  end
  
  def can_access
    @can_access = @user.id == current_user.id 
  end

  def can_access_by_user
    redirect_to profile_user_path(current_user) unless @can_access
  end
  
end
