# -*- encoding : utf-8 -*-
class AdUserRecordsController < ApplicationController
  def index
    @ad = Ad.find(params[:ad_id])
    @ad_user_records = AdUserRecord.where(:AD_ID =>
  params[:ad_id]).page(params[:page])
    @has_get_points_record_count = AdUserRecord.where(:AD_ID => params[:ad_id], :TRANS_STATUS => 3).count
  end

  def new
    @ad = Ad.find(params[:ad_id])
    @ad_user_record = AdUserRecord.new(:AD_ID => @ad.id, :BRANCH_ID => @ad.BRANCH_ID, :POINTS => @ad.POINTS, :DEDUCT_TYPE => @ad.DEDUCT_TYPE)
  end

  def search
    @ad = Ad.find(params[:ad_id])

    @user_ids = params[:user_ids]
    @ad_user_records = AdUserRecord.select([:USER_ID, :ID]).where(:AD_ID => params[:ad_id]).where("USER_ID in (#{@user_ids})").group("USER_ID").minimum(:ID)
    @has_get_points_record_count = AdUserRecord.where(:AD_ID => params[:ad_id], :TRANS_STATUS => 3).count

    @send_points_url = send_points_url(@ad_user_records.values)

    @no_exist_user_ids = []
    @repeat_user_ids = []
    @temp_user_ids = []
    @user_ids.split(/,/).each do |user_id|
        if @ad_user_records.key?(user_id.to_i)
          if @temp_user_ids.include? user_id
            @repeat_user_ids << user_id
          else
            @temp_user_ids << user_id
          end
        else
          @no_exist_user_ids << user_id
        end
    end
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

  private
  def send_points_url(ad_user_record_ids)
    args = { :uuid =>
    uuid, :ts => Time.now.to_i * 1000, :ids => ad_user_record_ids.join(',') }
    args[:secret] = sign(args, secret)

    "#{points_base_url}/api/refresAR.json?" + args.map {|key, value| "#{key}=#{value}"}.join('&')
  end
end