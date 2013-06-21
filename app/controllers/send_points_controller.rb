class SendPointsController < ApplicationController
  
  def index

  end

  def send_points
    args = { :uuid => uuid, :ts => Time.now.to_i * 1000, :ids => params[:points][:record_ids] }
    args[:secret] = sign(args, secret)

    redirect_to "#{points_base_url}/api/refresAR.json?" + args.map {|key, value| "#{key}=#{value}"}.join('&')
  end
end
