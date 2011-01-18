############################################################################
module Ghaki
  module Stats module Format
    class Base

      ######################################################################
      attr_accessor :title

      ######################################################################
      def initialize opts={}
        @title = opts[:title] || ''
      end

      ######################################################################
      def dump stats, out, title=@title
        dump_head stats, out, title
        dump_body stats, out, title
        dump_tail stats, out, title
      end

      def dump_head stats, out, title
      end

      def dump_body stats, out, title
      end

      def dump_tail stats, out, title
      end

    end # class
  end end # namespace
end # package
############################################################################
