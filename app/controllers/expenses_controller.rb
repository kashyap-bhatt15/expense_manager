class ExpensesController < ApplicationController
	before_filter :authenticate_user!
	
	# New expense form. Provide categories, locations and users to that form
  def new
  	@expense = Expense.new
		@categories = Category.all
		@locations = Location.all
		@users = User.all
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
  	puts params[:data]
  	#exit
  	#@expense = Expense.new(params[:expense])
		
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
		
		
    respond_to do |format|
      if @expense.save
        format.html { redirect_to new_expense_path, notice: 'Post was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end
end
