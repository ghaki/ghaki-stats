############################################################################
require 'singleton'
require 'ghaki/stats/base'

############################################################################
module Ghaki module Stats
  class App
    include Singleton

    #-----------------------------------------------------------------------
    DEF_STATS_OPTS = {}

    #-----------------------------------------------------------------------
    attr_writer :stats, :stats_opts

    #-----------------------------------------------------------------------
    def stats
      @stats ||= Ghaki::Stats::Base.new( self.stats_opts )
    end

    #-----------------------------------------------------------------------
    def stats_opts
      @stats_opts ||= DEF_STATS_OPTS.dup
    end

    end # class
end end # package
############################################################################

############################################################################
begin
  require 'ghaki/app/engine'
  Ghaki::App::Engine.class_eval do
    def stats      ; Ghaki::Stats::App.instance.stats       end
    def stats= val ; Ghaki::Stats::App.instance.stats = val end 

    def stats_opts      ; Ghaki::Stats::App.instance.stats_opts       end
    def stats_opts= val ; Ghaki::Stats::App.instance.stats_opts = val end
  end
rescue LoadError
end
############################################################################
