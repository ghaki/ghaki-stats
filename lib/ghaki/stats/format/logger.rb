require 'ghaki/stats/format/output'

############################################################################
module Ghaki  #:nodoc:
module Stats  #:nodoc:
module Format #:nodoc:

  # Default formatting for generating Statistics Reports using a Logger object.

  class Logger < Output

    # Dump heading info, which in this case is a minor began log.

    def dump_head stats, log, title
      if title.empty?
        log.minor.began 'dumping statistics'
      else
        log.box title
      end
    end

    # Dump footer info, which in this case is a minor ended log.

    def dump_tail stats, log, title
      if title.empty?
        log.minor.ended 'dumping statistics'
      else
        log.liner
      end
    end

  end # class
end end end
