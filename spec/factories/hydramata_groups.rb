# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hydramata_group, :class => 'Hydramata::Group' do
    name "MyString"
  end
end
