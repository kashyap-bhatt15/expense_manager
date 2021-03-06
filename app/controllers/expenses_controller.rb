# Expense controller. Used for methods that supports expense and payment forms
class ExpensesController < ApplicationController
	before_filter :authenticate_user!
	
	# New expense form. Provide categories, locations and users to that form
  def new
  	# To check whether it is expense form or payment form
  	# If it is payment form then amount is multiplied by -1 and then stored in expense table
  	@transaction = 1
  	if request.fullpath.include?("payments")
  		puts "payment in url"
  		@transaction = -1
  	end
  	@expense = Expense.new
  	
  	# Category and locations only in expense form
  	if @transaction == 1
			@categories = Category.all
			@locations = Location.all
			@users = User.all
		else
			@users = User.ne(id: current_user.id)
		end
		
		#@users = User.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => { :expense => @expense, 
      																:categories => @categories, 
      																:locations => @locations,
      																:users => @users 
    																}
									}
    end
  end
  
  # Save expense form details
  def create
  	#@expense = Expense.new(params[:expense])
		@transaction = params[:transaction].to_i
		# If it was from expense form
		if @transaction == 1
			@location = Location.new
			@location.name = params[:expense][:location]
		
			# If location is saved then go ahead with expense saving
			# From this point on we should have transaction but mongodb doesn't support transaction so for now we go ahead without it.
			if @location.save!
				@expense = Expense.new
				@expense.name = params[:expense][:name]
				@expense.amount = params[:expense][:amount]
				@expense.expense_date = params[:expense][:expense_date]
				@expense.location_id = @location.id
				@expense.category_id = params[:expense][:category]
			
				# If expense is saved then go ahead with user expense
				if @expense.save!
					no_of_users = params[:expense][:user_expenses].length
					params[:expense][:user_expenses].each do |user_id|
						if user_id != ''
							@user_expense = UserExpense.new
							@user_expense.user_id = user_id
							@user_expense.write_attribute(:payee_id, current_user.id)
							#@user_expense.payee_id = current_user.id
							@user_expense.amount = params[:expense][:amount].to_f / (no_of_users - 1).to_f
							@user_expense.expense_id = @expense.id

							@user_expense.save!
						end
					end
				else # else of expense.save
					# ToDo in future: Some roll back mechanism if expense is not saved.
				end
			else # else of location.save
				# ToDo in future: Some roll back mechanism if expense is not saved.
			end
		# If it was from payment form
		elsif @transaction == -1
			@expense = Expense.new
			@expense.amount = params[:expense][:amount]
			if @expense.save!
				@user_expense = UserExpense.new
				@user_expense.user_id = params[:expense][:user_expenses]
				@user_expense.write_attribute(:payee_id, current_user.id)
				@user_expense.amount = params[:expense][:amount].to_f
				@user_expense.expense_id = @expense.id

				@user_expense.save!
			else # else of expense.save
				# ToDo in future: Some roll back mechanism if expense is not saved.
			end
		end
		
		
    respond_to do |format|
      if @expense.save
        format.html { redirect_to home_index_path, notice: 'Post was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end
end
