class CreateHydramataCoreRelationship < ActiveRecord::Migration
  def change
    create_table :hydramata_core_relationships do |t|
      t.string :subject_id, null: false
      t.string :subject_type, limit: 32, null: false
      t.string :predicate, limit: 64, index: true, null: false
      t.string :target_id, null: false
      t.string :target_type, limit: 32, null: false
      t.string :creator_id, null: false
      t.string :creator_type, limit: 64, null: false
      t.timestamps
    end

    add_index :hydramata_core_relationships, [:subject_id, :subject_type], name: 'hc_rel_subject'
    add_index :hydramata_core_relationships, [:target_id, :target_type], name: 'hc_rel_target'
    add_index :hydramata_core_relationships, [:creator_id, :creator_type], name: 'hc_rel_creator'
    add_index :hydramata_core_relationships, [:predicate], name: 'hc_rel_predicate'
  end
end
