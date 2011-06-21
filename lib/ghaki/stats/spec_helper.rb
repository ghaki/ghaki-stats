require 'ghaki/stats/base'
require 'ghaki/stats/format/null'

module Ghaki #:nodoc:
module Stats #:nodoc:

# Helper for mocking Ghaki::Stats objects in unit tests.
module SpecHelper

  DEF_CLASS=Ghaki::Stats::Base

  # Creates Ghaki::Stats object:
  # - Using null sink formatting to avoid file access.
  def make_safe_stats klass=DEF_CLASS
    obj = klass.new
    obj.format = Ghaki::Stats::Format::Null.new
    obj
  end

  # Creates @stats member using :make_safe_stats
  def setup_safe_stats klass=DEF_CLASS
    @stats = make_safe_stats(klass)
  end

end
end end
