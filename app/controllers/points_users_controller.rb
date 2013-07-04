class PointsUsersController < ApplicationController

  def index
    @points_users = PointsUser.page(params[:page])
  end

  def search
    emails = params[:email].split(/,/).map{|s| "'#{s}'"}.join(',')
    @points_users = PointsUser.where("VERIFY_EMAIL in (#{emails})").page(params[:page])

    render action: "index"
  end

  def clear
    @points_user = PointsUser.find(params[:id])

    email_params = { 'EMAILED' => 0, 'VERIFY_EMAIL' => nil, 'VERIFY_TIME' => nil }
    @points_user.update_attributes(email_params)

    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to action: "index" }
    end
  end
end