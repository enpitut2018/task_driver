# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jwt_blacklist do
    jti "MyString"
    exp "2018-11-24 18:47:31"
  end
end
