require "bundler/vlad"

set :application, "hcking"
set :deploy_to, "/home/hacking43451/hcking"
set :user, "hacking43451"
set :domain, "#{user}@hcking.de"
set :ssh_flags, ['-p 45672']
set :repository, '~/hcking.git'

set :config_files, ['database.yml', 'newrelic.yml']

namespace :vlad do

  desc "Copy config files from shared/config to release dir"
  remote_task :copy_config_files, :roles => :app do
    config_files.each do |filename|
      run "cp #{shared_path}/config/#{filename} #{release_path}/config/#{filename}"
    end
  end

  desc "Make a call to the passenger to create a running instance"
  remote_task :call_passenger, :roles => :app do
    run "wget -O /tmp/bla.html http://wood.hcking.de"
  end

  desc "Compile coffeescript files"
  remote_task :coffee, :roles => :app do
    puts "Coffeescripts compilieren"
    require 'barista'
    require File.expand_path('../initializers/barista_config', __FILE__)
   
    if Rails.logger.nil?
      require 'logger'
      Rails.logger = Logger.new(STDOUT)
    end

    Rails.logger.debug "Hallo" 
    puts "hm.."
    puts Barista.class.name
    Barista.compile_all!
    #Rake::Task["barista:brew"].invoke
  end

end
