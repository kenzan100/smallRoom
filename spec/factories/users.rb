# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    email "MyString"
    name "MyString"
    token "MyString"
  end
end
