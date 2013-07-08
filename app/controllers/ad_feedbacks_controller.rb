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

  def create
    total_price = params[:ad_feedback].delete :TOTAL_PRICE
    @ad_feedback = AdFeedback.new(params[:ad_feedback])
    binding.pry
    @ad_feedback.TOTAL_PRICE = total_price.to_f * 100

    @ad_feedback.PAY_MODE = 10
    @ad_feedback.ORDER_STATUS = 4
    @ad_feedback.PAY_STATUS = 1
    @ad_feedback.CONFIRMD = 1

    @ad_user_record = @ad_feedback.to_ad_record

    begin
      AdFeedback.transaction do
        @ad_feedback.save!
        @ad_user_record.save!
      end

      redirect_to ad_ad_feedbacks_url(@ad), notice: "create ad user record success"
    rescue Exception => e
      render action: "new"
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