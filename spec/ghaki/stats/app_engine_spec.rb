############################################################################
require 'ghaki/stats/app'

############################################################################
module Ghaki module App module EngineTesting
  begin
    require 'ghaki/app/engine'

    describe Ghaki::App::Engine do

      context 'singleton' do
        subject { Ghaki::App::Engine.instance }
        it { should respond_to :stats }
        it { should respond_to :stats= }
        it { should respond_to :stats_opts }
        it { should respond_to :stats_opts= }
      end

      context 'singleton methods' do
        describe '#stats' do
          subject { Ghaki::App::Engine.instance.stats }
          specify { should be_an_instance_of(Ghaki::Stats::Base) }
          specify { should equal(Ghaki::Stats::App.instance.stats ) }
        end

        describe '#stats_opts' do
          subject { Ghaki::App::Engine.instance.stats_opts }
          specify { should be_an_instance_of(::Hash) }
        end
      end

    end

  rescue LoadError
    describe 'Ghaki::App::Engine' do
      pending 'external library not available: <ghaki/app/engine>'
    end
  end
end end end
############################################################################
