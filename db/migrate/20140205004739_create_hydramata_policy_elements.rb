class CreateHydramataPolicyElements < ActiveRecord::Migration
  def change
    create_table :hydramata_policy_elements do |t|
      t.integer :policy_id, index: true, null: false
      t.string :resource_type, index: true
      t.string :group_identifier, index: true
      t.string :action_name, indext: true
      t.timestamps
    end
  end
end
