# -*- encoding : utf-8 -*-
class AdsController < ApplicationController
  def index
    @ads = Ad.page(params[:pages]).per(10)
  end

  def search
    if params[:keyword]
      @ads = Ad.where("name like '%#{params[:keyword]}%'").page(params[:pages]).per(10)
    else
      @ads = Ad.page(params[:pages]).per(10)
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
    @ad = Ad.find(params[:id])
    @ad.ID = nil

  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def create
    @ad = Ad.new(params[:ad])

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


end
