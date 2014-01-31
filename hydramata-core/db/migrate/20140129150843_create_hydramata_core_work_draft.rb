class CreateHydramataCoreWorkDraft < ActiveRecord::Migration
  def change
    create_table :hydramata_core_work_drafts, id: false do |t|
      t.string :pid, unique: true, null: false, limit: 32
      t.string :work_type, limit: 64, index: true, null: false
      t.integer :owner_id
      t.string :owner_type, limit: 64
      t.text :attributes_store, limit: 2147483647
    end

    add_index :hydramata_core_work_drafts, [:owner_id, :owner_type]
  end
end
