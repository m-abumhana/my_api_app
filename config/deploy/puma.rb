# config/deploy/puma.rb

# Change these to match your app
set :puma_threads, [4, 16]
set :puma_workers, 0

set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,   "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma_access.log"
set :puma_error_log,  "#{release_path}/log/puma_error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/tmp/sockets #{shared_path}/tmp/pids"
    end
  end

  before :start, :make_dirs
end