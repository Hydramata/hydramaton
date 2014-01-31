class Hydramata::Core::Attachment < ActiveRecord::Base
  has_attached_file :attached
  validates :attached, attachment_presence: true

  validates :pid, uniqueness: true, presence: true
  validates :attached_to_pid, presence: true
end
