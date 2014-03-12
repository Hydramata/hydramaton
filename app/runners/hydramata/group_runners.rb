require_dependency './app/runners/hydramata/runner'

module Hydramata
  module GroupRunners
    class Index < Hydramata::Runner
      def run
        groups = Hydramata::Group.all
        callback(:success, groups)
      end
    end

    class Show < Hydramata::Runner
      def run(group_id)
        group = Hydramata::Group.find(group_id)
        callback(:success, group)
      end
    end

    class New < Hydramata::Runner
      def run
        group = Hydramata::Group.new_form_for(current_user)
        callback(:success, group)
      end
    end

    class Edit < Hydramata::Runner
      def run(group_id)
        group = Hydramata::Group.existing_form_for(current_user, group_id)
        callback(:success, group)
      end
    end
  end
end
