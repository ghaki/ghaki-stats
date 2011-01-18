############################################################################
require 'ghaki/stats/app'

############################################################################
module Ghaki module Stats module AppTesting
  describe Ghaki::App::Engine do

    context 'object' do
      subject { Ghaki::App::Engine.instance }
      it { should respond_to :stats }
      it { should respond_to :stats= }
      it { should respond_to :stats_opts }
      it { should respond_to :stats_opts= }
    end

    describe '#stats' do
      subject { Ghaki::App::Engine.instance.stats }
      specify { should be_an_instance_of(Ghaki::Stats::Base) }
    end

    describe '#stats_opts' do
      subject { Ghaki::App::Engine.instance.stats_opts }
      specify { should be_an_instance_of(::Hash) }
    end

    context 'default settings' do
      describe '#title' do
        subject { Ghaki::App::Engine.instance.stats.title }
        specify { should be_empty }
      end
      describe '#format' do
        subject { Ghaki::App::Engine.instance.stats.format }
        specify { should be_an_instance_of(Ghaki::Stats::Format::Logger) }
      end
    end

  end
end end end
############################################################################
