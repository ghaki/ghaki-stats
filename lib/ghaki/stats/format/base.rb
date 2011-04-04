############################################################################
module Ghaki  #:nodoc:
module Stats  #:nodoc:
module Format #:nodoc:

  # Base for Statistics Report formatting objects.

  class Base

    attr_accessor :title # Name of statistics report.

    def initialize opts={}
      @title = opts[:title] || ''
    end

    # Dump output from statistics object.

    def dump stats, out, title=@title
      dump_head stats, out, title
      dump_body stats, out, title
      dump_tail stats, out, title
    end

    # Generate header of report.

    def dump_head stats, out, title
    end

    # Generate body of report.
    def dump_body stats, out, title
    end

    # Generate footer of report.

    def dump_tail stats, out, title
    end

  end
end end end
