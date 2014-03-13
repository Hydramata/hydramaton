class Hydramata::GroupsController < ApplicationController
  include GroupRunners

  layout 'hydramata/1_column'
  before_action :set_hydramata_group, only: [:destroy]
  respond_to :html

  def run(klass, *args, &block)
    klass.new(self, &block).run(*args)
  end

  def index
    run(Index) do |on|
      on.success { |groups| @hydramata_groups = groups }
    end
  end

  def show
    @hydramata_group = run(Show, identifier_params).first
  end

  def new
    run(New, params[:hydramata_group]) do |on|
      on.success { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
  end

  def create
    run(Create, params[:hydramata_group]) do |on|
      on.success { |group, message|
        @hydramata_group = group
        respond_with(@hydramata_group, notice: message)
      }
      on.failure { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
  end

  def edit
    @hydramata_group = run(Edit, identifier_params).first
  end

  def update
    @hydramata_group = Hydramata::Group.existing_form_for(current_user, identifier_params)

    respond_to do |format|
      if @hydramata_group.update(hydramata_group_params)
        format.html { redirect_to @hydramata_group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hydramata_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hydramata_group.destroy
    respond_to do |format|
      format.html { redirect_to hydramata_groups_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hydramata_group
    @hydramata_group = Hydramata::Group.find(identifier_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hydramata_group_params
    params.permit(hydramata_group: [:name])[:hydramata_group] || {}
  end

  def identifier_params
    params.require(:id)
  end

end
