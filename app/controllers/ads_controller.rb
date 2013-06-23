class AdsController < ApplicationController
  def index
    @ads = Ad.page(params[:pages]).per(10)
  end

  def search
    if params[:ad] && params[:ad][:keyword]
      @ads = Ad.where("name like '%#{params[:ad][:keyword]}%'").page(params[:pages]).per(10)
    else
      @ads = Ad.page(params[:pages]).per(10)
    end
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def update
    @ad = Ad.find(params[:id])

    
  end

  def records
    @record = AdUserRecord.find(:AD_ID => params[id])
  end

end
