class CreateHydramataCoreWorkDraft < ActiveRecord::Migration
  def change
    create_table :hydramata_core_work_drafts do |t|
      t.string :pid, unique: true
      t.string :work_type, limit: 64, index: true
      t.text :serialized_attributes, limit: 2147483647
    end
  end
end
