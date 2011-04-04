require 'ghaki/app/mixable'
require 'ghaki/stats/base'

module Ghaki #:nodoc
module Stats #:nodoc

  # Mixin stats object with auto-first use object creation.
  #
  # Note: Creates new Base stats object, does not grab copy from App Engine.
  # ==== Example
  #
  #   class MyAction
  #     include Ghaki::Stats::Mixin
  #     def do_something
  #       stats.incr 'Did', 'Something'
  #     end
  #   end
  #
  #   myact = MyAction.new
  #   myact.do_something

  module Mixin
    include Ghaki::App::Mixable
    app_mixin_accessor Base, :stats
  end

end end
