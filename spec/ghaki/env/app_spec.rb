require 'ghaki/env/app'

describe Ghaki::App::Engine do

  context 'object' do
    subject { Ghaki::App::Engine.instance }
    it { should respond_to :environment }
    it { should respond_to :environment= }
    it { should respond_to :assert_environment }
    it { should respond_to :clear_environment }
    it { should respond_to :detect_environment }
  end

end
