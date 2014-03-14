require_dependency './app/runners/hydramata/runner'
require_dependency 'i18n'

module Hydramata
  module GroupRunners
    class Index < Hydramata::Runner
      def run
        groups = services.all_groups
        callback(:success, groups)
      end
    end

    class Show < Hydramata::Runner
      def run(group_id)
        group = services.find_group(group_id)
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
        I18n.t("hydramata.group.create.success", model_name: HumanReadableModelName(group))
      end
    end

    class Edit < Hydramata::Runner
      def run(group_id, attributes = {})
        group = services.edit_group_for(current_user, group_id, attributes)
        callback(:success, group)
      end
    end

    class Update < Hydramata::Runner
      def run(group_id, attributes)
        group = services.edit_group_for(current_user, group_id)
        if group.update(attributes)
          callback(:success, group, success_message(group))
        else
          callback(:failure, group)
        end
      end

      def success_message(group)
        I18n.t("hydramata.group.update.success", model_name: HumanReadableModelName(group))
      end
    end

    class Destroy < Hydramata::Runner
      def run(group_id)
        group = services.find_group(group_id)
        group.destroy
        callback(:success, group)
      end
    end

  end
end
