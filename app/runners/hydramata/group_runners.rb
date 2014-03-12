require_dependency './app/runners/hydramata/runner'

module Hydramata
  module GroupRunners
    class Index < Hydramata::Runner
      def run
        groups = Hydramata::Group.all
        callback(:success, groups)
      end
    end
  end
end
