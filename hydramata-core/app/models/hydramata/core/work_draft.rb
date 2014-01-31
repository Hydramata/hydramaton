class Hydramata::Core::WorkDraft < ActiveRecord::Base
  self.primary_key = :pid
  serialize :attributes_store

  validates :pid, presence: true, uniqueness: true
  validates :work_type, presence: true

  has_many :attachments, foreign_key: :attached_to_pid

  def self.query(controller, parameters)
    if work_type = parameters[:work_type]
      where(work_type: work_type)
    else
      all
    end
  end

  def self.fetch_work_type_by_pid(pid)
    (where(pid: pid).pluck(:work_type).first) || raise(ActiveRecord::RecordNotFound.new("Unable to find #{self} PID:#{pid.inspect}"))
  end

  # @TODO - For now, this works here; Its rather kludgy
  def files=(raw_files)
    raw_files.each do |file|
      attachments.build(pid: Hydramata::Core::NoidMintingService.call, attached: file)
    end
  end

  def files
    attachments.collect(&:attached)
  end

end
