require 'sinatra'
require 'asset_pipeline'
require 'helpers'
class App < Sinatra::Base
  configure do
    set :root, APP_ROOT
    set :opal_libs, %w{opal ruta reactive-ruby opal-browser}
  end
  include Asset_Pipeline
  helpers Helpers

  get '/' do
    erb :index
  end

  get /[^\/]/ do
      erb :index
  end


end
