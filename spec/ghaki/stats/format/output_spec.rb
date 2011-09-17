require 'ghaki/stats/format/output'
require 'ghaki/logger/spec_helper'

module Ghaki module Stats module Format module Output_Testing
describe Format::Output do
  include Ghaki::Logger::SpecHelper

  before(:each) do
    setup_safe_logger
    @subj = Format::Output.new
    @stats = {
      'a' => { 'b' => 12 },
      'c' => { 'd' => 34 },
    }
    @out = 'file'
    @title = 'msg'
  end

  subject { @subj }

  it { should be_kind_of(Format::Base) }

  describe '#dump_body' do
    it 'writes output' do
      subject.dump_body @stats, @logger, @title
      @logger.with_file do |file|
        file.rewind
        file.read.split("\n").should == [
          '# a:', sprintf('#     %8s : %c', 12, 'b'),
          '# c:', sprintf('#     %8s : %s', 34, 'd'),
        ]
      end
    end
  end

end
end end end end
