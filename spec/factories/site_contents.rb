FactoryBot.define do
  factory :site_content do
    key { Faker::Internet.slug }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    content_type { [ "text", "html", "markdown" ].sample }
  end
end
