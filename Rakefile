
task "environment" do
  require './bike_reports'
end

desc "List all the configured routes"
task :routes => [:environment] do
  require 'sinatra/decompile'

  rl = BikeReports::App.routes.each_with_object(Hash.new([])) do |verb, route_listing|
    verb[1].each do |route|
      route_listing[route[0].source] += [verb[0]]
    end
  end

  longest_column = rl.values.map { |v| v.join(", ").length }.max

  rl.each_pair do |route, methods|
    printf("%-#{longest_column}s %s\n", methods.sort.join(", "), Sinatra::Decompile.decompile(route))
  end
end

desc "Run a console with the application loaded"
task :console => [:environment] do
  require 'pry'
  pry
end

namespace :db do
  desc "Upgrade or initialize the database"
  task :migrate => [:environment] do
    DataMapper.auto_upgrade!
  end

  desc "Blow away the current database and start from scratch"
  task :reset => [:environment] do
    DataMapper.auto_migrate!
    Rake::Task['db:seed'].execute
  end

  desc "Seed the database with initial required data"
  task :seed => [:environment, 'db:migrate'] do
    # TODO
  end
end
