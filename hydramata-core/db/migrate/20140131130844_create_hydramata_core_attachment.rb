class CreateHydramataCoreAttachment < ActiveRecord::Migration
  def change
    create_table :hydramata_core_attachments, id: false do |t|
      t.string :pid, unique: true, null: false, limit: 32
      t.string :attached_to_pid, null: false, limit: 32
    end

    add_index :hydramata_core_attachments, :pid
    add_index :hydramata_core_attachments, :attached_to_pid
  end
end
