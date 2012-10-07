# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'EMPTY THE MONGODB DATABASE'
#Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
Mongoid.purge!

puts ''
puts 'SETTING UP SOME DEFAULT USER LOGIN'
user1 = User.create! :name => 'User1', :email => 'user1@example.com', :password => 'please1', :password_confirmation => 'please1'
user2 = User.create! :name => 'User2', :email => 'user2@example.com', :password => 'please2', :password_confirmation => 'please2'
user3 = User.create! :name => 'User3', :email => 'user3@example.com', :password => 'please3', :password_confirmation => 'please3'
user4 = User.create! :name => 'User4', :email => 'user4@example.com', :password => 'please4', :password_confirmation => 'please4'
puts 'Users created'
puts ''

puts 'CREATING SOME DEFAULT CATEGORIES'
cat1 = Category.create! :name => 'House rent', :description => 'House rent'
cat2 = Category.create! :name => 'Groceries', :description => 'Groceries'
cat3 = Category.create! :name => 'Household items', :description => 'Household items'
cat4 = Category.create! :name => 'Utilities', :description => 'Utilities'
cat5 = Category.create! :name => 'Miscellaneous', :description => 'Miscellaneous'
puts 'Categories created'
