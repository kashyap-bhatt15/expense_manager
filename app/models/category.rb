class Category
  include Mongoid::Document
  field :category, type: String
  field :description, type: String

  has_many :expenses
  
  validates_presence_of :name
end
