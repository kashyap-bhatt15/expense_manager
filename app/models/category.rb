# Category
class Category
  include Mongoid::Document
  field :name, type: String
  field :description, type: String

  has_many :expenses
  
  validates_presence_of :name
end
