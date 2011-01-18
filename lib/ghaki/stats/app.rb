require 'ghaki/app/engine'
require 'ghaki/stats/base'

module Ghaki
  module App
    class Engine

      DEF_STATS_OPTS = {}

      attr_writer :stats, :stats_opts

      def stats
        @stats ||= Ghaki::Stats::Base.new( self.stats_opts )
      end

      def stats_opts
        @stats_opts ||= DEF_STATS_OPTS.dup
      end

    end
  end
end
