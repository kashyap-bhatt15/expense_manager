# Location
class Location
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :latitude, type: String
  field :longitude, type: String
  
  has_many :expenses
  
  validates_presence_of :name
end
