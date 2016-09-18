require 'opal'
require 'reactive-ruby'
require 'browser'
require 'ruta'
require_tree './libs'

Ruta.configure do |config|
  # config.context_prefix = true
  # config.remote_require_contexts = 'assets/contexts/:context/load.rb'
end



require_tree './contexts/common'
require 'contexts/main/load'

Ruta::Router.define do
  root_to :main_layout
end
# puts Ruta.config.display
$document.ready do
  Ruta.start_app
end
