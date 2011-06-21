require 'ghaki/stats/format/null'

module Ghaki module Stats module Format module Null_Testing
describe Ghaki::Stats::Format::Null do

  before(:all) do
    @subj = Format::Null.new
  end

  subject { @subj }

  it { should be_kind_of(Format::Base) }

end
end end end end
