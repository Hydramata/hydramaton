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
      def run(attributes)
        group = services.new_group_for(current_user, attributes)
        callback(:success, group)
      end
    end

    class Create < Hydramata::Runner
      def run(attributes)
        group = services.new_group_for(current_user, attributes)
        if services.save_group(group, creators: current_user)
          callback(:success, group, success_message(group))
        else
          callback(:failure, group)
        end
      end

      def success_message(group)
        I18n.t("hydramata.group.create.success", model_name: group.class.model_name.human)
      end
    end

    class Edit < Hydramata::Runner
      def run(group_id)
        group = Hydramata::Group.existing_form_for(current_user, group_id)
        callback(:success, group)
      end
    end

    class Update < Hydramata::Runner
      def run(group_id, attributes)
        group = Hydramata::Group.existing_form_for(current_user, group_id)
        if group.update(attributes)
          callback(:success, group, success_message(group))
        else
          callback(:failure, group)
        end
      end

      def success_message(group)
        I18n.t("hydramata.group.update.success", model_name: group.class.model_name.human)
      end
    end

  end
end
