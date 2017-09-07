# config valid only for current version of Capistrano
lock "3.9.0"

set :application, "document_ocr_service"
set :repo_url, "git@github.com:rpx/document_ocr_service.git"

# Default branch is :master
ask :branch, 'master'

# default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/opt/rpx/document_ocr_service"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', '.env'

# default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'sudo service document_ocr_service restart'
      execute 'sudo service document_ocr_service_job restart'
    end
  end

  after :deploy, "deploy:restart"
  after :rollback, "deploy:restart"
end
