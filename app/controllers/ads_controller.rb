# -*- encoding : utf-8 -*-
class AdsController < ApplicationController
  def index
    @ads = Ad.page(params[:page])
  end

  def search
    if params[:keyword]
      @ads = Ad.where("name like '%#{params[:keyword]}%'").page(params[:page])
    else
      @ads = Ad.page(params[:page])
    end

    render action: "index"
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def new
    @ad = Ad.new
  end

  def copy
    @ad = Ad.find(params[:id]).dup

    render action: "new"
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def create
    @ad = Ad.new(params[:ad])

    refresh_ad_cache(@ad)
    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render json: @ad, status: :created, location: @ad }
      else
        format.html { render action: "new" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ad = Ad.find(params[:id])

    refresh_ad_cache(@ad)
    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to @ad, notice: 'ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy

    refresh_ad_cache(@ad)
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'ad was successfully destroy.' }
      format.json { head :no_content }
    end
  end

  def refresh_ad_cache(ad)
    cache_key = "#{@@CACHE[:AD]}#{params[:cacheKey]}"
    refresh_cache(cache_key)
  end
end
