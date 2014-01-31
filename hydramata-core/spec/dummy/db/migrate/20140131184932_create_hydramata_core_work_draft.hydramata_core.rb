# This migration comes from hydramata_core (originally 20140129150843)
class CreateHydramataCoreWorkDraft < ActiveRecord::Migration
  def change
    create_table :hydramata_core_work_drafts, id: false do |t|
      t.string :pid, unique: true, null: false
      t.string :work_type, limit: 64, index: true, null: false
      t.integer :owner_id
      t.string :owner_type, limit: 64
      t.text :attributes_store, limit: 2147483647
    end

    add_index :hydramata_core_work_drafts, [:owner_id, :owner_type]
  end
end
