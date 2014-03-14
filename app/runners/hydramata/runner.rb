require_dependency './app/runners/hydramata/named_callbacks'

module Hydramata
  # A Runner is responsible for performing the guts of what might traditionally
  # be a controller's action.
  #
  # It exists for two reasons:
  # * Controllers are extremely over-worked (parameter negotiation,
  #   authentication, authorization, marshalling an object, user messages via
  #   flash, and http response determination)
  # * The inner method content of a controller's action is subject to change
  #   especially as other implementors look to change the behavior.
  #
  # So, the Runner provides a seem in the code in which you can more readily
  # make changes to the "inner method"  of a route. In some ways, I see this as
  # a separation of state change and response; a somewhat analogous separation
  # to the Command/Query separation principle.
  class Runner
    attr_reader :context

    def self.run(context,*args,&block)
      new(context, &block).run(*args)
    end

    def initialize(context)
      @callbacks = NamedCallbacks.new
      @context = context
      yield(@callbacks) if block_given?
    end

    def current_user
      context.current_user
    end

    def services
      context.services
    end

    def callback(name, *args)
      @callbacks.call(name, *args)
      args
    end

    def run(*args)
      raise NotImplementedError.new("You must define #{self.class}#run")
    end
  end
end
