class Expense
  include Mongoid::Document
  include Mongoid::Timestamps
  field :amount, type: Float
  field :expense_date, type: Time
  
  belongs_to :category
  belongs_to :location
  
  validates_presence_of :amount
  validates_presence_of :expense_date
  
end
