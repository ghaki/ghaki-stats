require 'ghaki/stats/format/base'

############################################################################
module Ghaki  #:nodoc:
module Stats  #:nodoc:
module Format #:nodoc:

  # Default formatting for generating Statistics Reports using a Logger object.

  class Logger < Base

    # Dump heading info, which in this case is a minor began log.

    def dump_head stats, log, title
      if title.empty?
        log.box title
      else
        log.minor.began 'dumping statistics'
      end
    end

    # Dumps body of stats.

    def dump_body stats, log, title
      stats.keys.sort.each do |major|
        log.puts major + ':'
        stats[major].keys.sort.each do |minor|
          count = stats[major][minor]
          log.puts '    ' + count.to_s.rjust(8) + ' : ' + minor
        end
      end
    end

    # Dump footer info, which in this case is a minor ended log.

    def dump_tail stats, log, title
      unless title == ''
        log.liner
      else
        log.minor.ended 'dumping statistics'
      end
    end

  end # class
end end end
