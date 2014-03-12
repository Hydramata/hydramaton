class Hydramata::GroupsController < ApplicationController
  layout 'hydramata/1_column'
  before_action :set_hydramata_group, only: [:show, :edit, :update, :destroy]

  # GET /hydramata/groups
  # GET /hydramata/groups.json
  def index
    @hydramata_groups = Hydramata::Group.all
  end

  # GET /hydramata/groups/1
  # GET /hydramata/groups/1.json
  def show
  end

  # GET /hydramata/groups/new
  def new
    @hydramata_group = Hydramata::Group.new
  end

  # GET /hydramata/groups/1/edit
  def edit
  end

  # POST /hydramata/groups
  # POST /hydramata/groups.json
  def create
    @hydramata_group = Hydramata::Group.new(hydramata_group_params)

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