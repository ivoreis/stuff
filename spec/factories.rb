FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :username do |n|
    "username#{n}"
  end

  factory :user do
   email FactoryGirl.generate :email
   username FactoryGirl.generate :username
   password "please"
   password_confirmation "please"
  end
  factory :person do
  end
end