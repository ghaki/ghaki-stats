require 'ghaki/stats/base'

module Ghaki #:nodoc:
module Stats #:nodoc:

# RSpec Mocha helper for mocking Ghaki::Stats objects
module SpecHelper

  # Stubs :dump on Ghaki::Stats object to avoid file access.

  def setup_stats klass=Ghaki::Stats::Base
    @stats = klass.new
    @stats.stubs(:dump)
  end

end
end end
