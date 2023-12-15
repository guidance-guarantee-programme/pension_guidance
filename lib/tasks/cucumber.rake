unless ARGV.any? { |a| a =~ /^gems/ }
  begin
    require 'cucumber/rake/task'

    default_cucumber_options = lambda do |t|
      t.binary = 'bin/cucumber'
      t.bundler = false
      t.fork = true
    end

    namespace :cucumber do
      Cucumber::Rake::Task.new({ ok: 'test:prepare' },
                               'Run features that should pass') do |t|
        default_cucumber_options.call(t)
        t.profile = 'default'
      end

      Cucumber::Rake::Task.new({ wip: 'test:prepare' },
                               'Run features that are being worked on') do |t|
        default_cucumber_options.call(t)
        t.profile = 'wip'
      end

      Cucumber::Rake::Task.new({ rerun: 'test:prepare' },
                               'Record failing features and run only them if any exist') do |t|
        default_cucumber_options.call(t)
        t.profile = 'rerun'
      end

      desc 'Run all features'
      task all: %i[ok wip]

      task :statsetup do
        require 'rails/code_statistics'
        ::STATS_DIRECTORIES << ['Cucumber features', 'features'] if File.exist?('features')
        ::CodeStatistics::TEST_TYPES << 'Cucumber features' if File.exist?('features')
      end
    end

    desc 'Alias for cucumber:ok'
    task cucumber: 'cucumber:ok'

    task default: :cucumber

    # In case we don't have the generic Rails test:prepare hook, append a no-op task that we can depend upon.
    task 'test:prepare' do
    end

    task stats: 'cucumber:statsetup'
  rescue LoadError # Don't load anything when running the gems:* tasks
    desc 'Cucumber rake task not available (cucumber not installed)'
    task :cucumber do
      abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
    end
  end
end
