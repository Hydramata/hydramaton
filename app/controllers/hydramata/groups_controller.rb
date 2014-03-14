# @see Hydramata::Runner
#
# This controller looks different from other controllers. Why? In part because
# I am exploring another means of developing an application, one that can be
# extended without major code surgery.
class Hydramata::GroupsController < ApplicationController
  layout 'hydramata/1_column'
  respond_to :html

  self.runner_container = GroupRunners

  def index
    run do |on|
      on.success { |groups|
        @hydramata_groups = groups
        respond_with(@hydramata_groups)
      }
    end
  end

  def show
    run(identifier_params) do |on|
      on.success { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
  end

  def new
    run(hydramata_group_params) do |on|
      on.success { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
  end

  def create
    run(hydramata_group_params) do |on|
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
    run(identifier_params, hydramata_group_params) do |on|
      on.success { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
  end

  def update
    run(identifier_params, hydramata_group_params) do |on|
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

  def destroy
    run(identifier_params) do |on|
      on.success { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def hydramata_group_params
    params.permit(hydramata_group: [:name])[:hydramata_group] || {}
  end

  def identifier_params
    params.require(:id)
  end

end
