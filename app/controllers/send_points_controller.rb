class SendPointsController < ApplicationController
  
  def index

  end

  def send_points
    args = { :uuid => production_uuid, :ts => Time.now.to_i * 1000, :ids => params[:points][:record_ids] }
    args[:secret] = sign(args, production_secret)

    redirect_to "#{api_base_url}/refresAR.json?" + args.map {|key, value| "#{key}=#{value}"}.join('&')
  end
end
