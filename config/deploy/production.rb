# -*- encoding : utf-8 -*-
set :stage, :production
set :rvm_type, :system
set :rvm_ruby_version, '2.1.0@copernico'

server 'se-app-01.caiena.net',
       user: 'copernico',
       roles: %w{web app db}
