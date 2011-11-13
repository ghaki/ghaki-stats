require 'ghaki/stats/errors'

module Ghaki #:nodoc:

  class MissingMajorStatsError < RuntimeError
    attr_accessor :major
    def blurb
      " Major (#{@major})"
    end
    def initialize maj, msg='Missing Statistic'
      @major = maj
      super( msg + ':' + blurb() )
    end
  end

  class MissingMinorStatsError < MissingMajorStatsError
    attr_accessor :minor
    def blurb
      super() + " Minor (#{@minor})"
    end
    def initialize maj, min, msg='Missing Statistic'
      @minor = min
      super( maj, msg )
    end
  end

end
