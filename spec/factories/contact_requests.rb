FactoryBot.define do
  factory :contact_request do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    state { Faker::Address.state_abbr }
    subject { Faker::Lorem.sentence(word_count: 3) }
    message { Faker::Lorem.paragraph(sentence_count: 3) }
    referral { [ 'Google', 'Psychology Today', 'Friend/Colleague', 'Other' ].sample }

    trait :invalid do
      first_name { nil }
      last_name { nil }
      email { 'invalid-email' }
      state { nil }
      subject { nil }
      message { nil }
    end

    trait :minimal do
      first_name { 'John' }
      last_name { 'Doe' }
      email { 'john@example.com' }
      state { 'CA' }
      subject { 'Test Subject' }
      message { 'Test message' }
    end
  end
end
