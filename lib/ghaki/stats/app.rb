require 'ghaki/app/plugin'
require 'ghaki/stats/base'

module Ghaki #:nodoc:
module Stats #:nodoc:

  # Application wide statistics tracker.

  class App < Ghaki::App::Plugin
    app_plugin_make Base, :stats
    app_plugin_link :stats
  end

end end
