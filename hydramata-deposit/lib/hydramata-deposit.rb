module Hydramata::Deposit
  module_function

  def new_form_for(controller, work_type, options = {})
    finalize_new_form_for(work_type, options).new(controller)
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

  def reset_config!
    @new_forms_for = {}
  end

end

require "hydramata/deposit/engine"
require 'hydramata/deposit/works_responder'
require 'virtus'
