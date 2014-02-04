# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Hydramaton::Application.load_tasks

namespace :spec do
  plugin_directories = Dir['hydramata-*']
  desc "Run specs for all hydramata plugins"
  namespace :hydramata do
    plugin_directories.each do |plugin|
      component = plugin.sub(/hydramata\-/, '').to_sym
      desc "Run specs for #{plugin}"
      task component do
        Bundler.with_clean_env do
          FileUtils.cd(plugin)
          puts "\n*** Running plugin specs for #{plugin}"
          system("rspec")
          FileUtils.cd(File.expand_path('../', __FILE__))
        end
      end
    end
  end
  task :hydramata => ['spec'] + plugin_directories.collect {|dir| dir.gsub("-", ':') }
end

task default: 'spec:hydramata'