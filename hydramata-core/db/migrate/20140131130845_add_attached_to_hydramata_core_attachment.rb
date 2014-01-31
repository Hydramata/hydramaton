class AddAttachedToHydramataCoreAttachment < ActiveRecord::Migration
  def change
    add_attachment :hydramata_core_attachments, :attached
  end
end
