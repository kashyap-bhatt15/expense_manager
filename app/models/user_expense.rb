class UserExpense
  include Mongoid::Document
  
  field :amount, type: Float
  field :settled, type: Boolean, default: 0
  
  belongs_to :expense
  
  belongs_to :user
  #field :user_id, type: Integer
  #field :payee_id, type: Integer #refer  
  field :payee_id, type: Moped::BSON::ObjectId
  belongs_to :user
  #field :user_id, type: Integerence to user_id but no way to show in mongoid without
  
  validates_presence_of :amount
end
