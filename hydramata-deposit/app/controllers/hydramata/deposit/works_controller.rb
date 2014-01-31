class Hydramata::Deposit::WorksController < Hydramata::Deposit::ApplicationController
  respond_to :html

  layout "#{Hydramata.configuration.layout.theme}/1_column"

  class_attribute :responder, instance_predicate: false, instance_accessor: false
  self.responder = Hydramata::Deposit::WorksResponder
  prepend_view_path Hydramata::FormResolver.new(self)

  def show
    validate_request(presented_work)
    respond_with(presented_work)
  end

  def new
    validate_request(new_work)
    assign_attributes(new_work)
    respond_with(new_work)
  end

  def create
    validate_request(new_work)
    assign_attributes(new_work)
    create_deposit(new_work)
    respond_with(new_work)
  end

  def edit
    validate_request(existing_work)
    assign_attributes(existing_work)
    respond_with(existing_work)
  end

  def update
    validate_request(existing_work)
    assign_attributes(existing_work)
    update_deposit(existing_work)
    respond_with(existing_work)
  end

  protected
  def new_work
    @work ||= Hydramata::Deposit.new_form_for(self, params.fetch(:work_type))
  end

  def existing_work
    @work ||= Hydramata::Deposit.existing_form_for(self, params.fetch(:id))
  end

  def presented_work
    @work ||= Hydramata::Deposit.existing_form_for(self, params.fetch(:id))
  end

  attr_reader :work
  helper_method :work

  def validate_request(work)
    Hydramata::Deposit.authorize!(self, work)
  end

  def assign_attributes(work)
    work.attributes = params.fetch(:work) { Hash.new }
  end

  def create_deposit(work)
    work.save
  end

  def update_deposit(work)
    work.save
  end

end
