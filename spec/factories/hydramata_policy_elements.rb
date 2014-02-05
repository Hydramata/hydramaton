# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hydramata_policy_element, :class => 'Hydramata::PolicyElement' do
    policy_id 1
    group_identifier "MyString"
    action_name "MyString"
  end
end
