# This migration comes from hydramata_core (originally 20140131130843)
class CreateHydramataCoreRelationship < ActiveRecord::Migration
  def change
    create_table :hydramata_core_relationships do |t|
      t.string :subject_id, null: false
      t.string :subject_type, limit: 32, null: false
      t.string :predicate, limit: 64, index: true, null: false
      t.string :target_id, null: false
      t.string :target_type, limit: 32, null: false
      t.string :authority_id, null: false
      t.string :authority_type, limit: 64, null: false
      t.timestamps
    end

    add_index :hydramata_core_relationships, [:subject_id, :subject_type], name: 'hc_rel_subject'
    add_index :hydramata_core_relationships, [:target_id, :target_type], name: 'hc_rel_target'
    add_index :hydramata_core_relationships, [:authority_id, :authority_type], name: 'hc_rel_creator'
    add_index :hydramata_core_relationships, [:predicate], name: 'hc_rel_predicate'
  end
end
