class UsersController < ApplicationController
	before_filter :authenticate_user!

  def show
  	params[:data] = params[:id]
  	@user = User.find(params[:id])
  end
end
