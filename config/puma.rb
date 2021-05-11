#!/usr/bin/env puma

rackup DefaultRackup

environment ENV['RACK_ENV'] || 'development'

pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'

workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads Integer(ENV['MAX_THREADS'] || 5), Integer(ENV['MAX_THREADS'] || 5)

bind 'unix://tmp/sockets/puma.sock'
port ENV['PORT'] || 3000

worker_timeout 3600 if ENV['RACK_ENV']

preload_app!

# on_worker_boot do
#   # Worker specific setup for Rails 4.1+
#   # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
#   ActiveRecord::Base.establish_connection
# end
