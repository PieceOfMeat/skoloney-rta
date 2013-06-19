

FactoryGirl.define do
  factory :user do
    address   "Sanatornaya 9/2"
    birthday  "1986-09-02"
    city      "Donetsk"
    country   "Ukraine"
    email     "sergey.koloney@gmail.com"
    full_name "Sergey Koloney"
    login     "pieceofmeat"
    password  "123456"
    password_confirmation "123456"
    state     "Donetsk"
    zip       "83062"
    role      "common"
  end

  factory :advertisement do
    sequence(:content)  { |n| "Post #{n}" }
    sequence(:created_at) { |n| n.hours.ago }
    user
  end
end