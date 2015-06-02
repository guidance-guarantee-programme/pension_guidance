desc 'Analyse Javascript with JSHint and Javascript Code Style checker'
task :analyse_javascript do
  puts 'Running Javascript code analysis...'
  system('npm run js') || fail('Javascript analysis failed')
end
