require 'English'

desc 'Analyse Javascript with JSHint and Javascript Code Style checker'
task analyse_javascript: :environment do
  puts 'Running Javascript code analysis...'
  system('npm run js') || exit($CHILD_STATUS.exitstatus)
end
