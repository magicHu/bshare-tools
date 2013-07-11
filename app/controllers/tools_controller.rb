# -*- encoding : utf-8 -*-
class ToolsController < ApplicationController

  def index
  end

  def refreshCache
    cache_key = "#{@@CACHE[params[:type].to_sym]}#{params[:cacheKey]}"
  
    redirect_to refresh_cache_url(cache_key)
=begin
  
    message = refresh_cache(cache_key)
    if message
      redirect_to tools_index_url, alert: "refresh cache fail: #{message}" 
    else
      redirect_to tools_index_url, notice: "refresh cache success." 
    end
=end  
  end
end
