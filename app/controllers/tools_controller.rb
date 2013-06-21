class ToolsController < ApplicationController
  def index
  end

  def refreshCache
    redirect_to "#{points_base_url}/api/clearCached.json?uuid=#{uuid}&names=#{params[:cacheKey]}"
  end
end
