############################################################################
require 'ghaki/stats/base'

############################################################################
module Ghaki module Stats module BaseTesting
  describe Ghaki::Stats::Base do

    ########################################################################
    subject { Ghaki::Stats::Base.new }

    ########################################################################
    context 'object' do
      it { should respond_to :get }
      it { should respond_to :put }
      it { should respond_to :decr }
      it { should respond_to :incr }
      it { should respond_to :decr_by }
      it { should respond_to :incr_by }

      it { should respond_to :def_zero }
      it { should respond_to :def_value }
      it { should respond_to :def_zeros }
      it { should respond_to :def_values }

      it { should respond_to :set_gt }
      it { should respond_to :set_lt }

      it { should respond_to :clear }
      it { should respond_to :dump }
      it { should respond_to :flush }

      it { should respond_to :title }
      it { should respond_to :format }
    end

    ########################################################################
    context 'behavior' do
      it "should #put" do
        subject.put 'inputs', 'wrote', 3
        subject.get('inputs','wrote').should == 3
      end
      it 'should #clear' do
        subject.put 'inputs', 'broke', 3
        subject.clear
        subject.get('inputs','broke').should == 0
      end
    end

    ########################################################################
    context 'defaulting' do
      it "should default to zero when not set" do
        subject.get('inputs','bogus') == 0
      end
      it 'should #def_value when not present' do
        subject.def_value 'inputs', 'shadoobie', 23
        subject.get('inputs','shadoobie').should == 23
      end
      it 'should not #def_value when present' do
        subject.put 'inputs', 'shapoopie', 67
        subject.def_value 'inputs', 'shapoopie', 23
        subject.get('inputs','shapoopie').should == 67
      end
      it 'should #def_values when not present' do
        subject.def_values 'output', 100, 'zip', 'zap'
        subject.get('output','zip').should == 100
        subject.get('output','zap').should == 100
      end
      it "should #def_zero when not present" do
        subject.def_zero 'inputs', 'newbie'
        subject.get('inputs','newbie').should == 0
      end
      it "should not #def_zero when present" do
        subject.put('inputs','boogie',23)
        subject.def_zero 'inputs', 'boogie'
        subject.get('inputs','boogie').should == 23
      end
      it "should #def_zeros when not present" do
        subject.def_zeros({ 'animal' => 'cow', 'animal' => 'bear' })
        subject.get('animal','bear').should == 0
        subject.get('animal','cow').should == 0
      end

    end

    ########################################################################
    context 'up and down' do

      it "should #decr" do
        subject.put 'inputs', 'lost', 100
        subject.decr 'inputs', 'lost'
        subject.get('inputs','lost').should == 99
      end
      it "should #incr" do
        subject.put 'inputs', 'found', 100
        subject.incr 'inputs', 'found'
        subject.get('inputs','found').should == 101
      end

      it 'should #decr_by' do
        subject.put 'inputs', 'mu', 100
        subject.decr_by 'inputs', 'mu', 3
        subject.get('inputs','mu').should == 97
      end
      it 'should #incr_by' do
        subject.put 'inputs', 'pu', 100
        subject.incr_by 'inputs', 'pu', 3
        subject.get('inputs','pu').should == 103
      end
    end

    describe '#set_lt' do
      it 'should set when less' do
        subject.put 'particle', 'proton', 100
        subject.set_lt 'particle', 'proton', 90
        subject.get('particle','proton').should == 90
      end
      it 'should ignore when not less' do
        subject.put 'particle', 'proton', 100
        subject.set_lt 'particle', 'proton', 110
        subject.get('particle','proton').should == 100
      end
    end

    describe '#set_gt' do
      it 'should set when greater' do
        subject.put 'particle', 'proton', 100
        subject.set_gt 'particle', 'proton', 110
        subject.get('particle','proton').should == 110
      end
      it 'should ignore when not greater' do
        subject.put 'particle', 'proton', 100
        subject.set_gt 'particle', 'proton', 90
        subject.get('particle','proton').should == 100
      end
    end

  end
end end end
##########################################################################
