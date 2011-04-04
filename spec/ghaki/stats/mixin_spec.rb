############################################################################
require 'ghaki/stats/mixin'

############################################################################
module Ghaki module Stats module MixinTesting
  describe Ghaki::Stats::Mixin do

    class UsingMixin
      include Ghaki::Stats::Mixin
    end

    context 'object including' do
      subject { UsingMixin.new }
      it { should respond_to :stats  }
      it { should respond_to :stats= }
    end

    context '#stats' do
      subject { UsingMixin.new.stats }
      specify { should be_an_instance_of(Ghaki::Stats::Base) }
    end

  end
end end end
############################################################################
