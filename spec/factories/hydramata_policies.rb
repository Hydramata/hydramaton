# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hydramata_policy, :class => 'Hydramata::Policy' do
    sequence(:name) {|i| "Policy #{i}" }
  end
end
