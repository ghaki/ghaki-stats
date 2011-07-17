require 'ghaki/stats/format/base'

module Ghaki  #:nodoc:
module Stats  #:nodoc:
module Format #:nodoc:

# Default formatting for generating Statistics Reports using an output file object.

class Output < Base

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

end # class
end end end
