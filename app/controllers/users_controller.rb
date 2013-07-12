class UsersController < ApplicationController
  def index
    @users = User.page(params[:pages])
  end

  def search
    @users = User.where(params[:type] => params[:keyword])
  end
end
