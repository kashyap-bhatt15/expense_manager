class HomeController < ApplicationController
	before_filter :authenticate_user!
	
	# Method for showing home page to loggedIn user
  def index
  	@users = User.all

  	@pay = Array.new
  	@collect = Array.new
  	i = 0
  	@settlement_amount = Hash.new
  	@users.each do |user|
  		# If user is not eqaul to current user then calculate his/her dues/collection with that user
  		if user.id != current_user.id
  			# All to pay transactions in @pay and to collect transactions in @collect
  			@pay[i] = UserExpense.where(user_id: current_user.id).where(payee_id: user.id)
  			@collect[i] = UserExpense.where(user_id: user.id).where(payee_id: current_user.id)
  			# Calculate total to pay amount to this user
  			@pay_amount = 0
  			@pay[i].each do |pays|
  				@pay_amount += pays.amount
  			end
  			# Calculate total to collect from this user
  			@collect_amount = 0
  			@collect[i].each do |collects|
  				@collect_amount += collects.amount
  			end
  			@settlement_amount[user.id] = @pay_amount - @collect_amount
  			
  			i = i + 1
  		else
  			# Same as current user no need to do anything for common expense
  		end
  	end # Users loop end  	
  end # index method end
  
end
