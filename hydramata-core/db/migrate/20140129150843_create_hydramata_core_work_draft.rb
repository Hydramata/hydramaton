class CreateHydramataCoreWorkDraft < ActiveRecord::Migration
  def change
    create_table :hydramata_core_work_drafts, primary_key: false do |t|
      t.string :pid, unique: true
      t.string :work_type, limit: 64, index: true
      t.integer :owner
      t.string :owner_type, limit: 64
      t.text :attributes_store, limit: 2147483647
    end

    add_index :hydramata_core_work_drafts, [:owner, :owner_type]
  end
end
