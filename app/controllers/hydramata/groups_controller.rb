class Hydramata::GroupsController < ApplicationController
  include GroupRunners

  layout 'hydramata/1_column'
  before_action :set_hydramata_group, only: [:destroy]

  def run(klass, *args, &block)
    klass.new(self, &block).run(*args)
  end

  def index
    run(Index) do |on|
      on.success { |groups| @hydramata_groups = groups }
    end
  end

  def show
    params.require(:id)
    @hydramata_group = run(Show, params[:id]).first
  end

  def new
    @hydramata_group = run(New).first
  end

  def edit
    params.require(:id)
    @hydramata_group = run(Edit, params[:id]).first
  end

  def create
    @hydramata_group = Hydramata::Group.new_form_for(current_user)
    @hydramata_group.attributes = (params[:hydramata_group] || {})

    respond_to do |format|
      if @hydramata_group.save
        format.html { redirect_to @hydramata_group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hydramata_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @hydramata_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @hydramata_group = Hydramata::Group.existing_form_for(current_user, params[:id])

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
    @hydramata_group = Hydramata::Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hydramata_group_params
    params.require(:hydramata_group).permit(:name)
  end

end
