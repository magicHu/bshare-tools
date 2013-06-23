class AdUserRecordsController < ApplicationController
  def index
    @ad_user_records = AdUseRecord.find(:AD_ID => params[:ad_id]).page(params[:page])
  end

  def new
    @ad_user_record = AdUseRecord.build(:AD_ID => params[:ad_id])
  end

  def create
    @ad = Ad.find(params[:ad_id])
    @ad_user_record = @ad.ad_user_records.build(params[:ad_user_record])

    if @ad_user_record.save
      redirect_to action: index, notice: "create ad user record success"
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
