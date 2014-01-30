class CreateHydramataCoreWorkDraft < ActiveRecord::Migration
  def change
    create_table :hydramata_core_work_drafts, primary_key: false do |t|
      t.string :pid, unique: true
      t.string :work_type, limit: 64, index: true
      t.integer :creator
      t.string :creator_type, limit: 64
      t.text :serialized_attributes, limit: 2147483647
    end

    add_index :hydramata_core_work_drafts, [:creator, :creator_type]
  end
end
