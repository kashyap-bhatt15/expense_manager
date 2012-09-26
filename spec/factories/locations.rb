# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name "MyString"
    description "MyText"
    latitude "MyString"
    longitude "MyString"
  end
end
