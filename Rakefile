# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('config/application', __dir__)

Rails.application.load_tasks

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:default)
rescue LoadError
end

begin
  require 'scss_lint/rake_task'
  SCSSLint::RakeTask.new(:default)
rescue LoadError
end

task default: %i(analyse_javascript spec:javascript)
