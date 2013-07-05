# -*- encoding : utf-8 -*-
class ToolsController < ApplicationController

  def index
  end

  def refreshCache
    cache_key = "#{@@CACHE[params[:type].to_sym]}#{params[:cacheKey]}"
=begin
  
    response = HTTParty.get(refresh_cache_url(cache_key))

    if response.code == 200
      result = MultiJson.load(response.body)
      redirect_to tools_index_url, notice: "refresh cache success." unless result['isSuccess'] == 'F'
    end
    redirect_to tools_index_url, alert: "refresh cache fail." 
=end

    message = refresh_cache(cache_key)
    if message
      redirect_to tools_index_url, alert: "refresh cache fail: #{message}" 
    else
      redirect_to tools_index_url, notice: "refresh cache success." 
    end
    
  end
end
