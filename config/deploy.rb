# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'capistrano_sample'
set :repo_url, 'github.com:sugiura/capistrano_sample.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# rbenvの設定 (/usr/local/rbenv に 2.1.3 をインストールすることを想定)
set :rbenv_type, :system
set :rbenv_ruby, '2.1.3'

# bundlerを実行する際の引数
set :bundle_flags, "--deployment --without development test"

set :password, ask('Server password', nil)
server '192.168.1.249', user: 'sugiura', port: 22, password: fetch(:password), roles: %w{web app db}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
