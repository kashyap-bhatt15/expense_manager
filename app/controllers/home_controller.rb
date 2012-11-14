# Home Controller supports homepage after login
class HomeController < ApplicationController
	before_filter :authenticate_user!
	
	# Method for showing home page to loggedIn user
  def index
  	@users = User.all

  	@pay = Array.new
  	@collect = Array.new
  	i = 0
  	@settlement_amount = Hash.new
  	# Following two hashes for graph data
  	@to_pay_amount = Hash.new
  	@to_collect_amount = Hash.new
  	User.all.each do |user|
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
  			if @settlement_amount[user.id] > 0
  				@to_pay_amount[user.id] = Array.new
					@to_pay_amount[user.id][0] = @pay_amount - @collect_amount
					@to_pay_amount[user.id][0] = @to_pay_amount[user.id][0].round(2)
					#@to_pay_amount[user.id][0] = @to_pay_amount[user.id][0].to_f
					@to_pay_amount[user.id][1] = user.name
  			elsif @settlement_amount[user.id] < 0
					@to_collect_amount[user.id] = Array.new
					@to_collect_amount[user.id][0] = @collect_amount - @pay_amount
					@to_collect_amount[user.id][0] = @to_collect_amount[user.id][0].round(2)
					#@to_collect_amount[user.id][0] = @to_collect_amount[user.id][0].to_f
					@to_collect_amount[user.id][1] = user.name
  			else
  				@to_pay_amount[user.id] = 0
  				@to_collect_amount[user.id] = 0
  			end
  			i = i + 1
  		else
  			# Same as current user no need to do anything for common expense
  		end
  	end # Users loop end
    # Find the categorywise expense for current user.
    @my_expense_array = Array.new

    @user_expenses = UserExpense.where(user_id: current_user.id)
    @expense_ids = Array.new
    @user_expenses.each { |ue| @expense_ids << ue.expense_id }
    
    @my_expenses = Expense.find(@expense_ids)
    @category_ids = Array.new
    @my_expenses.each { |cat| @category_ids << cat.category_id }
  
    @user_expenses.length.times do |i|
      hashes = Hash.new
      hashes["expense_id"] = @user_expenses[i].expense_id
      hashes["category_id"] = @my_expenses[i].category_id
      hashes["amount"] = @user_expenses[i].amount
      hashes["expense_date"] = @my_expenses[i].expense_date
      hashes["user_id"] = current_user.id
      hashes["category_name"] = Category.find(@my_expenses[i].category_id)
      hashes["category_name"] = hashes["category_name"].name
      @my_expense_array << hashes
    end

    @category_wise_amount = Array.new
    @date_wise_amount = Array.new

    @categories = Array.new
    @category_positions = Array.new

    @dates = Array.new
    @date_positions = Array.new

    @my_expense_array.each do |me|
      # Category wise
      if !@categories.empty? && @categories.include?(me["category_name"])
        @category_wise_amount.each do |cwa|
          if cwa.has_key?(me["category_name"])
            cwa[me["category_name"]] = cwa[me["category_name"]].to_f.round(2) + me["amount"].to_f.round(2)
          end
        end
      else
        hashes = Hash.new
        hashes["#{me['category_name']}"] = me["amount"].to_f.round(2)
        #hashes["amount"] = me["amount"]
        @category_wise_amount << hashes
        @categories << me["category_name"]
        @category_positions << @category_wise_amount.length - 1
        
      end
      # Date wise
      if !@dates.empty? && @dates.include?(me["expense_date"].strftime('%a %b %d, %Y'))
        @date_wise_amount.each do |dwa|
          if dwa.has_key?(me["expense_date"].strftime('%a %b %d, %Y'))
            dwa[me["expense_date"].strftime('%a %b %d, %Y')] = dwa[me["expense_date"].strftime('%a %b %d, %Y')] + me["amount"].to_f.round(2)
          end
        end
      else
        hashes = Hash.new
        date_expenses = Array.new
        hashes["#{me['expense_date'].strftime('%a %b %d, %Y')}"] = me["amount"].to_f.round(2)
        #hashes["amount"] = me["amount"]
        @date_wise_amount << hashes
        @dates << me["expense_date"].strftime('%a %b %d, %Y')
        @date_positions << @date_wise_amount.length - 1
      end
    end


  end # index method end

  def graph_date(d)
    d.strftime('%a %b %d, %Y')
  end
end
