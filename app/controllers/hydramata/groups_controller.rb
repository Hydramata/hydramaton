class Hydramata::GroupsController < ApplicationController
  include GroupRunners

  layout 'hydramata/1_column'
  before_action :set_hydramata_group, only: [:show, :destroy]

  def run(klass, *args, &block)
    klass.new(self, &block).run(*args)
  end

  # GET /hydramata/groups
  # GET /hydramata/groups.json
  def index
    run(Index) do |on|
      on.success { |groups| @hydramata_groups = groups }
    end
  end

  # GET /hydramata/groups/1
  # GET /hydramata/groups/1.json
  def show
  end

  # GET /hydramata/groups/new
  def new
    @hydramata_group = Hydramata::Group.new_form_for(current_user)
    @hydramata_group.attributes = (params[:hydramata_group] || {})
  end

  # GET /hydramata/groups/1/edit
  def edit
    @hydramata_group = Hydramata::Group.existing_form_for(current_user, params[:id])
    @hydramata_group.attributes = (params[:hydramata_group] || {})
  end

  # POST /hydramata/groups
  # POST /hydramata/groups.json
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

  # PATCH/PUT /hydramata/groups/1
  # PATCH/PUT /hydramata/groups/1.json
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

  # DELETE /hydramata/groups/1
  # DELETE /hydramata/groups/1.json
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
