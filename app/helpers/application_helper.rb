# Application helper
module ApplicationHelper

	# Return the user name from user id
	def get_user_name(user_id)
		user = User.find(user_id)
		return user.name
	end
	
	# Return proper date format from mongodb time stamp
	def get_date(date)
		if date != nil
			temp = Date.parse date.to_s
			return temp.strftime("%a, %b %d %Y")
		else
			return "Not specifed"
		end
	end
	
	# Format and prep settlement amount from code understanding format to user understanding format.
	def get_settlement(settlement_amount, user_name)
		settlement_amount = settlement_amount.round(2)
		#settlement_amount = "%0.2f" % settlement_amount
		settle_text = "Some error in function...."
		if settlement_amount > 0
			settle_text = "You need to pay <b>$" + settlement_amount.to_s + "</b> to " + user_name + "."
		elsif settlement_amount < 0
			settlement_amount *= -1
			settle_text = "You need to collect <b>$" + settlement_amount.to_s + "</b> from " + user_name + "."
		else
			settle_text = "You are <b>even</b> with " + user_name + "."
			
		end
		return settle_text
	end
end
