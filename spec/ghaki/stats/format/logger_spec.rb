require File.join(File.dirname(__FILE__),'../../..', 'mocha_helper')
require 'ghaki/stats/format/logger'

module Ghaki module Stats module Format module Logger_Testing
describe Ghaki::Stats::Format::Logger do

  before(:all) do
    @subj = Format::Logger.new
    @stats = {
      'a' => { 'b' => 12 },
      'c' => { 'd' => 34 },
    }
    @out = 'file'
    @title = 'msg'
    @logger = stub_everything()
    @logger.stubs( :minor => stub_everything() )

    @log_data = []
    @logger.stubs(:puts) do |s|
      @log_data.push s
    end
  end

  subject { @subj }

  it { should be_kind_of(Format::Base) }

  describe '#dump_head' do
    context 'with no title' do
      it 'logs start of dump' do
        @logger.minor.expects(:began).with('dumping statistics').once
        subject.dump_head @stats, @logger, ''
      end
    end
    context 'with given title' do
      it 'logs header title' do
        @logger.expects(:box).with(@title).once
        subject.dump_head @stats, @logger, @title
      end
    end
  end

  describe '#dump_body' do
    it 'writes output' do
      subject.dump_body @stats, @logger, @title
      pending
    end
  end

  describe '#dump_tail' do
    context 'with no title' do
      it 'logs ending of dump' do
        @logger.minor.expects(:ended).with('dumping statistics').once
        subject.dump_tail @stats, @logger, ''
      end
    end
    context 'with given title' do
      it 'logs footer line' do
        @logger.expects(:liner).once
        subject.dump_tail @stats, @logger, @title
      end
    end
  end

end
end end end end
