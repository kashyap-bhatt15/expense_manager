# Users controller. Created by devise. Not used either right now.
class UsersController < ApplicationController
	before_filter :authenticate_user!

	# Show all users
  def show
  	params[:data] = params[:id]
  	@user = User.find(params[:id])
  end
end
