require 'ghaki/stats/spec_helper'

module Ghaki module Stats module SpecHelper_Testing
describe SpecHelper do
  include Ghaki::Stats::SpecHelper

  class Fake < Stats::Base
  end

  before(:each) do
    @stats = nil
  end

  describe '#make_safe_stats' do
    it 'returns stats object' do
      @stats = make_safe_stats()
      @stats.should be_instance_of(Ghaki::Stats::Base)
    end
    it 'uses null sink for formatting' do
      @stats = make_safe_stats()
      @stats.format.should be_instance_of(Ghaki::Stats::Format::Null)
    end
    it 'accepts stats class' do
      @stats = make_safe_stats(Fake)
      @stats.should be_instance_of(Fake)
    end
  end

  describe '#setup_safe_stats' do
    it 'creates stats member value' do
      setup_safe_stats()
      @stats.should be_instance_of(Ghaki::Stats::Base)
    end
    it 'accepts stats class' do
      setup_safe_stats(Fake)
      @stats.should be_instance_of(Fake)
    end
  end

end
end end end
