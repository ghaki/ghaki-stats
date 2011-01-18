require 'ghaki/stats/format/base'

############################################################################
module Ghaki
  module Stats module Format
    class Logger < Base

      ######################################################################
      def dump_head stats, log, title
        if title.empty?
          log.box title
        else
          log.minor.began 'dumping statistics'
        end
      end

      ######################################################################
      def dump_body stats, log, title
        stats.keys.sort.each do |major|
          log.puts major + ':'
          stats[major].keys.sort.each do |minor|
            count = stats[major][minor]
            log.puts '    ' + count.to_s.rjust(8) + ' : ' + minor
          end
        end
      end

      ######################################################################
      def dump_tail stats, log, title
        unless title == ''
          log.liner
        else
          log.minor.ended 'dumping statistics'
        end
      end

    end # class
  end end # namespace
end # package
############################################################################
