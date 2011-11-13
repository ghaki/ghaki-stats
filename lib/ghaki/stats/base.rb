require 'ghaki/stats/errors'
require 'ghaki/stats/format/logger'

############################################################################
module Ghaki #:nodoc
module Stats #:nodoc

  class Base

    attr_accessor :title # Title of statistics output report.
    attr_writer :format  # Statistics output report Formatting object.

=begin
[+format+] Statistics report formatting object.
[+title+]  Title of statistics output report.
=end

    def initialize opts={}
      clear
      @format = opts[:format]
      @title  = opts[:title] || ''
    end

    # Get the formatter for the statistical report.
    #
    # Note: Will generate default formatting object if not already set.

    def format
      @format ||= self._format_default
    end


    # Assign zeroe to a stats count if its not already set.

    def def_zero major, minor
      def_value major, minor, 0
    end

    # Assign zeroes to multiple stats counts if they're not already set.

    def def_zeros major_to_minor
      major_to_minor.each_pair do |major,minor_s|
        [*minor_s].each do |minor|
          def_zero major, minor
        end
      end
    end

    # Assign multiple stats counts if not already set.

    def def_values major, value, *minors
      minors.each { |minor| def_value major, minor, value }
    end

    # Assign default stats count value if not already set.

    def def_value major, minor, value
      @stats[major] ||= {}
      @stats[major][minor] = value unless @stats[major].has_key?(minor)
    end

    # Increase stats count by 1.

    def incr major, minor
      incr_by major, minor, 1
    end

    # Decrease stats count by 1.

    def decr major, minor
      decr_by major, minor, 1
    end

    # Increase stats count by a given value.

    def incr_by major, minor, value
      def_zero major, minor
      @stats[major][minor] += value
    end

    # Decrease stats count by a given value

    def decr_by major, minor, value
      def_zero major, minor
      @stats[major][minor] -= value
    end

    # Set stats count to a given value.

    def put major, minor, value
      @stats[major] ||= {}
      @stats[major][minor] = value
    end

    # Is stat present?

    def has? major, minor=nil
      if @stats.has_key?(major)
        if minor.nil?
          true
        else
          @stats[major].has_key?(minor)
        end
      else
        false
      end
    end

    # Is stat missing?

    def lacks? major, minor=nil
      ! has?(major,minor)
    end

    # Throw exception if stat is mising.

    def has! major, minor=nil
      return self if has? major, minor
      if minor.nil?
        raise MissingMajorStatsError.new(major)
      else
        raise MissingMinorStatsError.new(major, minor)
      end
    end

    # Get current value of stats count. Defaults to zero when not present.

    def get major, minor
      return 0 unless @stats.has_key?(major)
      return 0 unless @stats[major].has_key?(minor)
      return @stats[major][minor]
    end

    # Get current value or throw exception.

    def get! major, minor
      has!(major,minor).get(major,minor)
    end

    # Get current value of stats count. Defaults to specified when not present.

    def get? major, minor, defval=nil
      if has? major, minor
        get major, minor
      else
        defval
      end
    end

    # Set stats value if given value is greater than current value.

    def set_gt major, minor, value
      if not @stats.has_key?(major)
        @stats[major] = { minor => value }
      elsif not @stats[major].has_key?(minor)
        @stats[major][minor] = value
      elsif @stats[major][minor] < value
        @stats[major][minor] = value
      end
    end

    # Set stats value if given value is less than current value.

    def set_lt major, minor, value
      if not @stats.has_key?(major)
        @stats[major] = { minor => value }
      elsif not @stats[major].has_key?(minor)
        @stats[major][minor] = value
      elsif @stats[major][minor] > value
        @stats[major][minor] = value
      end
    end

    # Clears statistic counts.

    def clear
      @stats = {}
    end

    # Writes statistics report to specified output file.

    def dump out_file, title=@title
      format.dump @stats, out_file, title
    end

    # Logger specific dump. (DEPRECATED)

    def log_dump logger, title=@title
      warn "[DEPRECATED] 'log_dump' is deprecated.  Please use 'dump' instead."
      dump logger, title
    end

    # Writes statistics report to specified output file, and clears statistic counts.
    def flush out_file, title=@title
      dump out_file, title
    ensure
      clear
    end

    # Logger specific flush. (DEPRECATED)

    def log_flush logger, title=@title
      warn "[DEPRECATED] 'log_flush' is deprecated.  Please use 'flush' instead."
      flush logger, title
    end

    protected

    def _format_default #:nodoc
      opts = {}
      opts[:title] = @title unless @title.nil?
      Ghaki::Stats::Format::Logger.new( opts )
    end

  end
end end
