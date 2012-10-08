class RecommendationsController < ApplicationController
  before_filter :authenticate_user!, :load_user
  before_filter :load_user_recommendation, :only => [:show, :destroy, :feedback, :submit_feedback]
  before_filter :recommendee_can_access, :only => [:show, :destroy]
  before_filter :recommender_can_access, :only => [:show, :destroy, :feedback, :submit_feedback]
  before_filter :current_user_can_access, :only => [:index, :new, :create]
  before_filter :can_access_by_recommendee_or_recommender, :only => [:show, :destroy, :feedback, :submit_feedback]
  before_filter :can_access_by_current_user, :only => [:index, :new, :create]
  
  # GET /recommendations/1
  # GET /recommendations/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @recommendation }
    end
  end

  # GET /recommendations
  # GET /recommendations.json
  def index
    @pending_sent_recommendations = @user.sent_recommendations.pending
    @done_sent_recommendations = @user.sent_recommendations.done
    @pending_received_recommendations = @user.received_recommendations.pending
    @done_received_recommendations = @user.received_recommendations.done

    @recommendations = @pending_sent_recommendations + @done_sent_recommendations + @pending_received_recommendations + @done_received_recommendations
    
    respond_to do |format|
      format.html
      format.json { render json: @recommendations }
    end
  end

  # GET /recommendations/new
  # GET /recommendations/new.json
  def new
    @recommendation = @user.sent_recommendations.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommendation }
    end
  end

  # POST /recommendations
  # POST /recommendations.json
  def create
    @recommendation = @user.sent_recommendations.build(params[:recommendation])
    @recommender = User.find_by_email(params[:recommendation][:recommender_email])
    @recommendation.recommender = @recommender if @recommender
    
    respond_to do |format|
      if @recommendation.save
        format.html { redirect_to user_recommendations_path(@user) }
        format.json { render json: @recommendation, status: :created, location: @recommendation }
        flash[:notice] = "Your Recommendation has been sent."
      else
        format.html { render action: "new" }
        format.json { render json: @recommendation.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /recommendations/1
  # DELETE /recommendations/1.json
  def destroy
    @recommendation.destroy
    respond_to do |format|
      format.html { redirect_to user_recommendations_path(@user) }
      format.json { head :no_content }
      flash[:notice] = "Recommendation has been deleted."
    end
  end

  def feedback
  end

  def submit_feedback
    @recommendation.update_attribute(:feedback_text, params[:recommendation][:feedback_text])
    redirect_to user_recommendations_path(current_user)
  end

  private
  def load_user
    @user = User.find(params[:user_id])
  end

  def load_user_recommendation
    @recommendation = @user.sent_recommendations.find(params[:id])
  end

  def current_user_can_access
    @can_access = @user.id == current_user.id unless @can_access
  end
  
  def recommendee_can_access
    @can_access = @recommendation.recommendee.id == current_user.id unless @can_access
  end

  def recommender_can_access
    @can_access = @recommendation.recommender.id == current_user.id unless @can_access
  end

  def can_access_by_recommendee_or_recommender
    redirect_to user_recommendations_path(current_user) unless @can_access
  end

  def can_access_by_current_user
    redirect_to user_recommendations_path(current_user) unless @can_access
  end
  
end
