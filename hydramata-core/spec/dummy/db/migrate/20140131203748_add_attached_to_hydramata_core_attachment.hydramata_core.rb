# This migration comes from hydramata_core (originally 20140131130845)
class AddContentToHydramataCoreAttachment < ActiveRecord::Migration
  def change
    add_attachment :hydramata_core_attachments, :attached
  end
end
