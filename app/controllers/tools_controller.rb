class ToolsController < ApplicationController

  @@CACHE = {
    AD: 'P:AD'
  }

  def index
  end

  def refreshCache
    #cache_key = params[:cacheKey]
    cache_key = "#{@@CACHE[params[:type].to_sym]}#{params[:cacheKey]}"

    redirect_to "#{points_base_url}/api/clearCached.json?uuid=#{uuid}&names=#{cache_key}"
  end
end
