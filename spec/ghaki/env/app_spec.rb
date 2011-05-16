require 'ghaki/env/app'

ENV['GHAKI_RUN_ENV'] = 'test'

describe Ghaki::App::Engine do

  context 'object' do
    subject { Ghaki::App::Engine.instance }
    it { should respond_to :environment }
    it { should respond_to :environment= }
    it { should respond_to :assert_environment }
    it { should respond_to :clear_environment }
    it { should respond_to :detect_environment }

    describe '#environment' do
      it 'should actually see ENV[GHAKI_RUN_ENV]' do
        subject.environment.should == :test
      end
    end

  end

end
