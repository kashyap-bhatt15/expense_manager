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
user1 = User.create! :name => 'Thomas', :email => 'thomas@example.com', :password => 'thomas1', :password_confirmation => 'thomas1'
user2 = User.create! :name => 'Smith', :email => 'smith@example.com', :password => 'smith1', :password_confirmation => 'smith1'
user3 = User.create! :name => 'Clark', :email => 'clark@example.com', :password => 'clark1', :password_confirmation => 'clark1'
user4 = User.create! :name => 'Davis', :email => 'davis@example.com', :password => 'davis1', :password_confirmation => 'davis1'
user4 = User.create! :name => 'Adams', :email => 'adams@example.com', :password => 'adams1', :password_confirmation => 'adams1'
puts 'Users created'
puts ''

puts 'CREATING SOME DEFAULT CATEGORIES'
cat1 = Category.create! :name => 'House rent', :description => 'House rent'
cat2 = Category.create! :name => 'Groceries', :description => 'Groceries'
cat3 = Category.create! :name => 'Household items', :description => 'Household items'
cat4 = Category.create! :name => 'Utilities', :description => 'Utilities'
cat5 = Category.create! :name => 'Miscellaneous', :description => 'Miscellaneous'
puts 'Categories created'
