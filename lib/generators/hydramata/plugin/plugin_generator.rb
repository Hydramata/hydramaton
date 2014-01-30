require 'rails/generators'
require 'rails/generators/rails/plugin_new/plugin_new_generator'
module Hydramata::Generators
  module_function
  def path_to_rails_template(path)
    File.join(Bundler.definition.specs['railties'].first.full_gem_path, path)
  end
  class InternalAppGenerator < Rails::Generators::AppGenerator
    source_root Hydramata::Generators.path_to_rails_template("lib/rails/generators/rails/app/templates")
    def app_name
      File.basename(destination_root).tr(".", "_")
    end
    def app_const_base
      app_name.classify
    end
  end
  class PluginBuilder < Rails::PluginBuilder
    def readme
      template "README.md"
    end

    def gemfile
      template "Gemfile"
    end

    def license
      template "LICENSE"
    end

    def gemspec
      template "%original_name%.gemspec"
    end

    def generate_test_dummy(force = false)
      template "spec/spec_helper.rb"

      opts = (options || {}).slice(*PASSTHROUGH_OPTIONS)
      opts[:force] = true
      opts[:skip_bundle] = true
      invoke Hydramata::Generators::InternalAppGenerator,
        [ File.expand_path(dummy_path, destination_root) ], opts
    end

  end
  class PluginGenerator < Rails::Generators::PluginNewGenerator

    source_root Hydramata::Generators.path_to_rails_template("lib/rails/generators/rails/plugin_new/templates")

    def initialize(*args)
      parameters = args
      parameters[1] << "--dummy-path=spec/internal"
      parameters[1] << "-T"
      @without_name_space = parameters[0][0].downcase
      parameters[0][0] = "hydramata-" << without_name_space
      super(*parameters)
    end

    def name
      super.gsub("-", "/")
    end

    private
    attr_reader :without_name_space


    def camelized
      name.camelize
    end

    def get_builder_class
      Hydramata::Generators::PluginBuilder
    end

    def valid_const?
      if original_name =~ /[^0-9a-zA-Z_\-\:]+/
        raise Rails::Generators::Error, "Invalid plugin name #{original_name}. Please give a name which use only alphabetic or numeric or \"_\" characters."
      elsif camelized =~ /^\d/
        raise Rails::Generators::Error, "Invalid plugin name #{original_name}. Please give a name which does not start with numbers."
      elsif Rails::Generators::RESERVED_NAMES.include?(name)
        raise Rails::Generators::Error, "Invalid plugin name #{original_name}. Please give a name which does not match one of the reserved rails words."
      elsif Hydramata.const_defined?(without_name_space.classify)
        raise Rails::Generators::Error, "Invalid plugin name #{original_name}, constant #{camelized} is already in use. Please choose another plugin name."
      end

    end
  end
end
