require 'ghaki/stats/app'

describe Ghaki::App::Engine do

  before(:all) do
    @app_eng = Ghaki::App::Engine.instance
    @sta_app = Ghaki::Stats::App.instance
  end

  context 'singleton' do
    subject { @app_eng }
    it { should respond_to :stats }
    it { should respond_to :stats= }
    it { should respond_to :stats_opts }
    it { should respond_to :stats_opts= }
    it { should respond_to :stats_defs }
    it { should respond_to :stats_defs= }
  end

  describe '#stats' do
    subject { @app_eng.stats }
    specify { should be_an_instance_of(Ghaki::Stats::Base) }
    specify { should equal(@sta_app.stats ) }
  end

  describe '#stats_opts' do
    subject { @app_eng.stats_opts }
    specify { should be_an_instance_of(::Hash) }
  end

  describe '#stats_defs' do
    subject { @app_eng.stats_defs }
    specify { should be_an_instance_of(::Hash) }
  end

end
