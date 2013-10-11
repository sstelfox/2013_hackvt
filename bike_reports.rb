
require 'json'

require 'sinatra/base'
require 'sinatra/namespace'

require 'lib/init_database'

module BikeReports
  class App < Sinatra::Base
    enable :logging, :sessions, :method_override

    set :root, File.expand_path(File.dirname(__FILE__))
    set :views, (self.root + '/views')
    set :public_folder, (self.root + '/public')

    configure :development do
      enable :raise_errors
      enable :show_exceptions
    end

    register Sinatra::Namespace

    get '/' do
      erb :index
    end

    not_found do
      erb :'404'
    end

    error do
      erb :error
    end
  end
end

