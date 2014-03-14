# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Hydramaton::Application.load_tasks

namespace :spec do
  plugin_directories = Dir['hydramata-*']
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
  desc "Run specs for all hydramata plugins"
  task :hydramata => ['db:test:prepare', 'spec'] + plugin_directories.collect {|dir| dir.gsub("-", ':') }

  desc 'Run the Travis CI specs'
  task :travis do
    ENV['RAILS_ENV'] = 'test'
    ENV['SPEC_OPTS'] = "--profile 20"
    Rails.env = 'test'
    Rake::Task['db:create'].invoke
    Rake::Task['db:test:prepare'].invoke
    Rake::Task['spec'].invoke
  end
end

task default: 'spec:hydramata'

begin
  require 'rspec/yenta'
  RSpec::Yenta.load_tasks do
    require File.expand_path("../config/environment.rb",  __FILE__)
  end
rescue LoadError
  puts "Unable to load rspec/yenta; No matches for you!"
end

begin
  require 'yard/rake/yardoc_task'
  YARD::Rake::YardocTask.new(:doc) do |t|
    t.files   = ['app/**/*.rb', 'lib/**/*.rb', '-', 'README.md', 'LICENSE']
    t.options
  end
rescue LoadError
  puts "Unable to load yard/rake/yardoc_task; No docs for you!"
end

# Removing doc:app as this isn't working
['doc:app', 'test', 'test:all', 'test:all:db', 'test:uncommitted', 'test:recent'].each do |task_name|
  Rake::Task[task_name].clear rescue true
end
