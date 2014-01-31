module Hydramata::Deposit
  module_function

  def new_form_for(controller, work_type, options = {})
    finalize_new_form_for(work_type, options).new(controller)
  end

  def existing_form_for(controller, identifier, options = {})
    work_type_finder = options.fetch(:work_type_finder) { Hydramata::Core::WorkDraft.method(:fetch_work_type_by_pid) }
    work_type = work_type_finder.call(identifier)
    finalize_new_form_for(work_type, options).new(controller, identifier)
  end

  def finalize_new_form_for(work_type, options = {})
    @new_forms_for ||= {}
    @new_forms_for[work_type.to_s] ||= begin
      configuration = options.fetch(:config) { Hydramata.configuration.deposit }
      finalizer = options.fetch(:finalizer) { Hydramata::FormFinalizer }
      work_config = configuration.new_form_for.fetch(work_type)
      finalizer.call(work_type, work_config)
    end
    @new_forms_for[work_type.to_s]
  end

  def authorize!(controller, work)
    true
  end

  def reset_configuration!
    @new_forms_for = {}
  end
end

require "hydramata/deposit/engine"
