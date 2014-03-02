FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "secretpassword"
    confirmation_sent_at = Time.now
    after(:create) { |user| user.confirm! }
  end
end
