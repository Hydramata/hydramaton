class CreateHydramataPolicyElements < ActiveRecord::Migration
  def change
    create_table :hydramata_policy_elements do |t|
      t.integer :policy_id, index: true, null: false
      t.string :resource_type, index: true, null: false
      t.string :group_identifier, index: true, null: false
      t.string :action_name, indext: true, null: false
      t.timestamps
    end
  end
end
