class Hydramata::Core::WorkDraft < ActiveRecord::Base
  serialize :attributes_store


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
end