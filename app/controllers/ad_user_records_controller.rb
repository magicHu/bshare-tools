class AdUserRecordsController < ApplicationController
  def index
    @ad = Ad.find(params[:ad_id])
    @ad_user_records = AdUserRecord.where(:AD_ID => params[:ad_id]).page(params[:page])
  end

  def new
    @ad = Ad.find(params[:ad_id])
    @ad_user_record = AdUserRecord.new(:AD_ID => @ad.id)
  end

  def search
    @ad = Ad.find(params[:ad_id])
    @ad_user_records = AdUserRecord.select([:USER_ID, :ID]).where("USER_ID in ('#{params[:user_ids]}')").group("USER_ID").minimum(:ID)

  end

  def create
    @ad = Ad.find(params[:ad_id])
    @ad_user_record = AdUserRecord.new(params[:ad_user_record])

    if @ad_user_record.save
      redirect_to ad_ad_user_records_url(@ad), notice: "create ad user record success"
    else
      render_to action: new
    end
  end

  def send_points
    args = { :uuid => uuid, :ts => Time.now.to_i * 1000, :ids => params[:id] }
    args[:secret] = sign(args, secret)

    redirect_to "#{points_base_url}/api/refresAR.json?" + args.map {|key, value| "#{key}=#{value}"}.join('&')
  end
end
