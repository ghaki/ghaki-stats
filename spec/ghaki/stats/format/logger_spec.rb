require 'ghaki/stats/format/logger'
require 'ghaki/logger/spec_helper'

require File.join(File.dirname(__FILE__),'../../..', 'mocha_helper')

module Ghaki module Stats module Format module Logger_Testing
describe Format::Logger do
  include Ghaki::Logger::SpecHelper

  before(:all) do
    setup_safe_logger
    @subj = Format::Logger.new
    @stats = {
      'a' => { 'b' => 12 },
      'c' => { 'd' => 34 },
    }
    @out = 'file'
    @title = 'msg'
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
        @logger.with_file do |file|
          file.rewind
          puts "WROTE #{file.read}"
        end
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
