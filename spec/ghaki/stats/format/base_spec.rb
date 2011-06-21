require 'ghaki/stats/format/base'

module Ghaki module Stats module Format module Base_Testing
describe Ghaki::Stats::Format::Base do

  before(:all) do
    @subj = Format::Base.new
    @stats = {}
    @out = 'file'
    @title = 'msg'
  end

  subject { @subj }

  describe '#initialize' do
    it 'accepts option :title' do
      Format::Base.new( :title => 'msg' ).title.should == 'msg'
    end
    it 'defaults option: title' do
      Format::Base.new().title.should == ''
    end
  end

  it { should respond_to :dump_head }
  it { should respond_to :dump_body }
  it { should respond_to :dump_tail }

  describe '#dump' do
    it 'dump header' do
      subject.expects(:dump_head).with(@stats,@out,@title).once
      subject.dump @stats, @out, @title
    end
    it 'dump stats body' do
      subject.expects(:dump_body).with(@stats,@out,@title).once
      subject.dump @stats, @out, @title
    end
    it 'dump footer' do
      subject.expects(:dump_tail).with(@stats,@out,@title).once
      subject.dump @stats, @out, @title
    end
  end

end
end end end end
