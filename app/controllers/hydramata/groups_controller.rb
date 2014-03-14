class Hydramata::GroupsController < ApplicationController
  layout 'hydramata/1_column'
  respond_to :html

  include GroupRunners
  def run(klass, *args, &block)
    klass.new(self, &block).run(*args)
  end

  def index
    run(Index) do |on|
      on.success { |groups|
        @hydramata_groups = groups
        respond_with(@hydramata_groups)
      }
    end
  end

  def show
    run(Show, identifier_params) do |on|
      on.success { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
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
    run(Create, hydramata_group_params) do |on|
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
    run(Edit, identifier_params, hydramata_group_params) do |on|
      on.success { |group|
        @hydramata_group = group
        respond_with(@hydramata_group)
      }
    end
  end

  def update
    run(Update, identifier_params, hydramata_group_params) do |on|
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
    run(Destroy, identifier_params) do |on|
      on.success {|group| respond_with(group) }
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
