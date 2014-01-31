# This migration comes from hydramata_core (originally 20140131130843)
class CreateHydramataCoreRelationship < ActiveRecord::Migration
  def change
    create_table :hydramata_core_relationships do |t|
      t.string :subject_id, limit: 32
      t.string :subject_type, limit: 32
      t.string :relationship, limit: 64, index: true
      t.string :target_id, limit: 32
      t.string :target_type, limit: 32
      t.integer :creator_id
      t.string :creator_type, limit: 64
      t.timestamps
    end

    add_index :hydramata_core_relationships, [:subject_id, :subject_type], name: 'hc_rel_subject'
    add_index :hydramata_core_relationships, [:target_id, :target_type], name: 'hc_rel_target'
    add_index :hydramata_core_relationships, [:creator_id, :creator_type], name: 'hc_rel_creator'
  end
end
