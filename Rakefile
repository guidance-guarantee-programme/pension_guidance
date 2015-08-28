# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

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

Rake::Task['spec:javascript'].clear

namespace :spec do
  desc 'Run the code examples in spec/javascripts with PhantomJS'
  task javascript: [:environment] do
    unless Rails.env.test?
      system('RAILS_ENV=test bundle exec rake spec:javascript')
      next
    end
    require 'jasmine_rails/runner'
    JasmineRails::Runner.run ENV['SPEC'], ENV.fetch('REPORTERS', 'console')
  end
end

task default: %i(analyse_javascript spec:javascript)
