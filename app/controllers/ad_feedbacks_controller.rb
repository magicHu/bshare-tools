class AdFeedbacksController < ApplicationController
  
  before_filter :find_ad

  def index
    @ad_feedbacks = AdFeedback.where(:AD_ID => @ad.ID).page(params[:page])
  end

  def new
    @ad_feedback = AdFeedback.new(:AD_ID => @ad.ID, :BRANCH_ID => @ad.BRANCH_ID)
  end

  def show
    @ad_feedback = AdFeedback.find(params[:id])
  end

  def edit
    @ad_feedback = AdFeedback.find(params[:id])
  end

  def create
    @ad_feedback = AdFeedback.new(params[:ad_feedback])

    if @ad_feedback.save
      redirect_to ad_ad_feedbacks_url(@ad), notice: "create ad user record success"
    else
      render_to action: "new"
    end
  end

  def destroy
    @ad_feedback = AdFeedback.find(params[:id])

    @ad_feedback.destroy

    redirect_to action: "index"
  end

  private
  def find_ad
    @ad = Ad.find(params[:ad_id])
  end
end