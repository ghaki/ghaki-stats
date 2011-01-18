############################################################################
require 'ghaki/stats/base'

############################################################################
module Ghaki
  module Stats
    module Mixin

      attr_writer :stats

      def stats
        @stats ||= Ghaki::Stats::Base.new
      end

    end # helper
  end # namespace
end # package
############################################################################
