# -*- encoding : utf-8 -*-
set :application, 'copernico'
set :repo_url, 'git@github.com:copernico-ide/copernico'
set :deploy_to, '/copernico/app'
set :keep_releases, 5
set :ping_url, "ideusp.caiena.net"
set :sprockets_asset_host, "localhost"
set :deploy_via, :remote_cache
# set :default_shell, 'bash -l'

namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :ping do
    system "curl #{fetch(:ping_url)} > /dev/null"
  end

  task :configure do
    on roles(:app) do
      execute :cp, "#{deploy_to}/config/database.yml", release_path.join('config/')
    end
  end
end

def _get_branch
  print "\n  * ", "-" * 50, "\n"
  puts "    Deploy: Type branch name, tag name or SHA1. Default: [ master ]"
  branch_name = $stdin.gets.chomp
  branch_name = 'master' if branch_name == ''
  puts "    Deploying: [ #{branch_name} ]\n"
  print "  * ", "-" * 50, "\n"

  branch_name
end

set :branch, ENV['BRANCH'] || _get_branch

before "deploy:compile_assets", "deploy:configure"
after "deploy:restart", "deploy:ping"
