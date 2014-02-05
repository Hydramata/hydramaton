class Hydramata::PolicyElement < ActiveRecord::Base
  self.table_name = 'hydramata_policy_elements'
  belongs_to :policy
end
