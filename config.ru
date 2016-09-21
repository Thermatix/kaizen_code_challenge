file = __FILE__
[File.dirname(file),File.expand_path('../app', file),File.expand_path('../lib', file)].each do |dir|
  $LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)
end

require 'yaml'
require 'rack-livereload'
require 'puma'
require 'mongoid'
require 'grape-entity'

config = {}
$ENV = {}
YAML.load(File.open(File.join(File.dirname(__FILE__), 'config.yml'))).each do |config_group, options|
  case config_group
  when :config
    options.each do |key,value|
      config[key.to_sym] = value
    end
  when :envs
    if options
      options.each do |key,value|
        $ENV[key] = value
      end
    end
  end
end

Mongoid.load!("#{File.dirname(file)}/mongoid.yml",:development)

require './middlewares/manifest'
require 'app_autoloader'

require_relative 'csv_to_db'

Sinatra::Application.reset!
use Rack::Reloader
use Rack::Deflater
use Rack::Session::Cookie, :key => config[:cookie][:key],
                           :path => config[:cookie][:key],
                           :secret => Digest::SHA1.hexdigest(rand.to_s)
use Headers
use X_Headers
use Rack::LiveReload,config[:live_reload]

use Subdomain_Dispatcher do
  set 'headers', Headers
  set 'x-headers', X_Headers
end

map '/api' do
  run API
end

run App


