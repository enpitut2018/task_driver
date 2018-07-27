# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :oauth do
    user_id 1
    access_token "MyString"
    access_token_secret "MyString"
  end
end
