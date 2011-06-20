require 'ghaki/stats/base'

module Ghaki module Stats module Base_Testing
describe Ghaki::Stats::Base do

  before(:each) do
    @subj = Ghaki::Stats::Base.new
  end

  subject { @subj }

  it { should respond_to :title }
  it { should respond_to :title= }
  it { should respond_to :format= }

  describe '#put' do
    it 'stores value' do
      subject.put 'inputs', 'wrote', 3
      subject.get('inputs','wrote').should == 3
    end
  end

  describe '#has?' do
    it 'detects major-only missing' do
      subject.put 'a', 'b', 3
      subject.has?('c').should be_false
    end
    it 'detects major-only present' do
      subject.put 'a', 'b', 3
      subject.has?('a').should be_true
    end
    it 'detects missing minor' do
      subject.put 'a', 'b', 3
      subject.has?('a','c').should be_false
    end
    it 'detects present minor' do
      subject.put 'a', 'b', 3
      subject.has?('a','b').should be_true
    end
  end

  describe '#get' do
    it 'retrieves value when set' do
      subject.put 'inputs','present',23
      subject.get('inputs','present').should == 23
    end
    it "defaults to zero when not set" do
      subject.get('inputs','bogus').should == 0
    end
  end

  describe '#clear' do
    it 'removes all values' do
      subject.put 'inputs', 'broke', 3
      subject.clear
      subject.has?('inputs','broke').should be_false
    end
  end

  describe '#def_value' do
    it 'stores given value when not present' do
      subject.def_value 'inputs', 'shadoobie', 23
      subject.get('inputs','shadoobie').should == 23
    end
    it "leaves stored value alone" do
      subject.put 'inputs', 'shapoopie', 67
      subject.def_value 'inputs', 'shapoopie', 23
      subject.get('inputs','shapoopie').should == 67
    end
  end

  describe '#def_values' do
    it 'stores given value when not present' do
      subject.def_values 'output', 100, 'zip', 'zap'
      subject.get('output','zip').should == 100
      subject.get('output','zap').should == 100
    end
  end

  describe '#def_zero' do
    it "stores zero when not present" do
      subject.def_zero 'inputs', 'newbie'
      subject.get('inputs','newbie').should == 0
    end
    it "leaves stored value alone" do
      subject.put('inputs','boogie',23)
      subject.def_zero 'inputs', 'boogie'
      subject.get('inputs','boogie').should == 23
    end
  end

  describe '#def_zeros' do
    it "stores zeros when not present" do
      subject.def_zeros({ 'animal' => 'cow', 'animal' => 'bear' })
      subject.get('animal','bear').should == 0
      subject.get('animal','cow').should == 0
    end
  end

  describe '#decr' do
    it "decrements stored value" do
      subject.put 'inputs', 'lost', 100
      subject.decr 'inputs', 'lost'
      subject.get('inputs','lost').should == 99
    end
  end

  describe '#incr' do
    it "increments stored value" do
      subject.put 'inputs', 'found', 100
      subject.incr 'inputs', 'found'
      subject.get('inputs','found').should == 101
    end
  end

  describe '#decr_by' do
    it 'decrements stored value by a given value' do
      subject.put 'inputs', 'mu', 100
      subject.decr_by 'inputs', 'mu', 3
      subject.get('inputs','mu').should == 97
    end
  end

  describe '#incr_by' do
    it 'increments stored value by a given value' do
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

  def setup_fake_values
    @subj.put 'a', 'b', 3
    @subj.put 'c', 'd', 5
    @expected_hash = { 'a' => { 'b' => 3 }, 'c' => { 'd' => 5 } }
  end
  def setup_fake_output
    @out = stub_everything()
  end
  def stub_formatter
    subject.format.expects(:dump).once
  end

  describe '#dump' do
    before(:each) do setup_fake_values; setup_fake_output end
    it 'outputs to formatter' do
      subject.format.expects(:dump).with(@expected_hash,@out,'msg').once
      subject.dump @out, 'msg'
    end
  end

  describe '#flush' do
    before(:each) do setup_fake_values; setup_fake_output end
    it 'dumps to formatter' do
      subject.expects(:dump).with(@out,'msg').once
      subject.flush @out, 'msg'
    end
    it 'clears all values' do
      stub_formatter
      subject.flush @out, 'msg'
      subject.has?('a','b').should be_false
      subject.has?('c','d').should be_false
    end
  end

  describe '#log_dump' do
    before(:each) do setup_fake_output end
    it 'warns of deprecation' do
      stub_formatter
      subject.expects(:warn).with(regexp_matches(%r{\[DEPRECATED\]})).once
      subject.log_flush @out, 'msg'
    end
    it 'calls #dump' do
      subject.expects(:warn).once
      subject.expects(:dump).with(@out,'msg').once
      subject.log_dump @out, 'msg'
    end
  end

  describe '#log_flush' do
    before(:each) do setup_fake_output end
    it 'warns of deprecation' do
      stub_formatter
      subject.expects(:warn).with(regexp_matches(%r{\[DEPRECATED\]})).once
      subject.log_flush @out, 'msg'
    end
    it 'calls #flush' do
      subject.expects(:warn).once
      subject.expects(:flush).with(@out,'msg').once
      subject.log_flush @out, 'msg'
    end
  end

end
end end end
