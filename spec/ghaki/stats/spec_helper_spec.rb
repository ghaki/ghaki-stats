require File.join(File.dirname(__FILE__),'../..', 'mocha_helper')

require 'ghaki/stats/spec_helper'

module Ghaki module Stats module SpecHelper_Testing
describe SpecHelper do
  include Ghaki::Stats::SpecHelper

  before(:each) do
    setup_stats
  end

  subject { @stats }

  describe '#setup_stats' do

    it 'stubs :dump to prevent file access' do
      @out = stub_everything()
      subject.format.expects(:dump).never
      subject.dump @out, 'msg'
    end

  end

end
end end end
