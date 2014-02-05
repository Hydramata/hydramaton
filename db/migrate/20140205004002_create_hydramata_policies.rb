class CreateHydramataPolicies < ActiveRecord::Migration
  def change
    create_table :hydramata_policies do |t|
      t.string :name, unique: true, index: true, null: false
      t.text :description
      t.timestamps
    end
  end
end
