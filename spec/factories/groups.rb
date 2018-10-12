# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    parent_id 1
    name "MyString"
    user_id 1
    importance 1
    deadline "2018-10-12 07:07:45"
  end
end
