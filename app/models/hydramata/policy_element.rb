class Hydramata::PolicyElement < ActiveRecord::Base
  self.table_name = 'hydramata_policy_elements'
  validates :resource_type, presence: true
  validates :group_identifier, presence: true
  validates :action_name, presence: true
  belongs_to :policy
end
