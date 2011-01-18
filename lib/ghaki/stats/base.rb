############################################################################
require 'ghaki/stats/format/logger'

############################################################################
module Ghaki
  module Stats
    class Base

      ######################################################################
      attr_accessor :title
      attr_writer :format

      ######################################################################
      def initialize opts={}
        clear
        @format = opts[:format]
        @title  = opts[:title] || ''
      end

      ######################################################################
      def format
        @format ||= self._format_default
      end

      ######################################################################
      def _format_default
        opts = {}
        opts[:title] = @title unless @title.nil?
        Ghaki::Stats::Format::Logger.new( opts )
      end

      ######################################################################
      def def_zero major, minor
        def_value major, minor, 0
      end

      ######################################################################
      def def_zeros major_to_minor
        major_to_minor.each_pair do |major,minor_s|
          [*minor_s].each do |minor|
            def_zero major, minor
          end
        end
      end

      ######################################################################
      def def_values major, value, *minors
        minors.each { |minor| def_value major, minor, value }
      end

      ######################################################################
      def def_value major, minor, value
        @stats[major] ||= {}
        @stats[major][minor] = value unless @stats[major].has_key?(minor)
      end

      ######################################################################
      def incr major, minor
        incr_by major, minor, 1
      end

      ######################################################################
      def decr major, minor
        decr_by major, minor, 1
      end

      ######################################################################
      def incr_by major, minor, value
        def_zero major, minor
        @stats[major][minor] += value
      end

      ######################################################################
      def decr_by major, minor, value
        def_zero major, minor
        @stats[major][minor] -= value
      end

      ######################################################################
      def put major, minor, value
        @stats[major] ||= {}
        @stats[major][minor] = value
      end

      ######################################################################
      def get major, minor
        return 0 unless @stats.has_key?(major)
        return 0 unless @stats[major].has_key?(minor)
        return @stats[major][minor]
      end

      ######################################################################
      def set_gt major, minor, value
        if not @stats.has_key?(major)
          @stats[major] = { minor => value }
        elsif not @stats[major].has_key?(minor)
          @stats[major][minor] = value
        elsif @stats[major][minor] < value
          @stats[major][minor] = value
        end
      end

      ######################################################################
      def set_lt major, minor, value
        if not @stats.has_key?(major)
          @stats[major] = { minor => value }
        elsif not @stats[major].has_key?(minor)
          @stats[major][minor] = value
        elsif @stats[major][minor] > value
          @stats[major][minor] = value
        end
      end

      ######################################################################
      def clear
        @stats = {}
      end

      ######################################################################
      def dump out_file, title=@title
        fmt.dump @stats, out_file, title
      end

      def log_dump logger, title=@title
        warn "[DEPRECATED] 'log_dump' is deprecated.  Please use 'dump' instead."
        dump logger, title
      end

      ######################################################################
      def flush out_file, title=@title
        dump out_file, title
      ensure
        clear
      end

      def log_flush logger, title=@title
        warn "[DEPRECATED] 'log_flush' is deprecated.  Please use 'flush' instead."
        flush logger, title
      end

    end # class
  end # namespace
end # package
############################################################################
