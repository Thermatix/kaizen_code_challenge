APP_ROOT = File.dirname(__FILE__)
require 'opal'


%w{controllers decorators models}.each do |app_dir|
  Dir["app/#{app_dir}/*.rb"].each do |file|
    require file
  end
end
