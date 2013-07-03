class BindUserAccountsController < ApplicationController

  def index
    @bind_user_accounts = BindUserAccount.all
  end

  def show
    @bind_user_account = BindUserAccount.find(params[:id])
  end

  def search
    @bind_user_accounts = BindUserAccount.where("ACCOUNT_NAME like '#{params[:keyword]}%'")

    render action: "index"
  end

  def new
    @bind_user_account = BindUserAccount.new
  end

  def create
    @bind_user_account = BindUserAccount.new(params[:bind_user_account])

    @bind_user_account.save!
    redirect_to action: "index", notice: "@bind_user_account.ACCOUNT_NAME is created successful."
  end

  def destroy
    @bind_user_account = BindUserAccount.find(params[:id])
    @bind_user_account.destroy

    redirect_to action: "index", notice: "@bind_user_account.ACCOUNT_NAME is removed successful."
  end
end