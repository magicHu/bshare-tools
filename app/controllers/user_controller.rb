class UserController < ApplicationController
  def roles
    @roles = Role.all
  end
end
