FactoryBot.define do
  factory :game do
    mode { %i(pvp pve both).sample }
    release_date { "2021-07-16 01:55:42" }
    developer { Faker::Company.name }
    system_requirement
  end
end
