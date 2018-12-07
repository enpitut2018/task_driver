# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    user nil
    task nil
    finish_time "2018-12-06 04:12:57"
    is_finish? false
  end
end
