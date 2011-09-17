############################################################################
require 'ghaki/env/engine'

############################################################################
module Ghaki module Env module EngineTesting
  describe Ghaki::Env::Engine do

    ########################################################################
    subject { Ghaki::Env::Engine.instance }
    context 'singleton instance' do
      it { should respond_to :environment }
      it { should respond_to :environment= }
      it { should respond_to :assert_environment }
      it { should respond_to :clear_environment }
      it { should respond_to :detect_environment }
    end

    ########################################################################
    def clear_all
      ENV.delete('GHAKI_RUN_ENV')
      ENV.delete('RAILS_ENV')
      ENV.delete('RACK_ENV')
      Object.send( :remove_const, :Sinatra )   if defined? ::Sinatra
      Object.send( :remove_const, :Merb )      if defined? ::Merb
      Object.send( :remove_const, :RAILS_ENV ) if defined? ::RAILS_ENV
    end

    before(:all) do clear_all end
    after(:each) do clear_all end

    ########################################################################
    describe '#assert_environment' do
      it 'complains when missing' do
        lambda {
          subject.assert_environment
        }.should raise_error( ArgumentError, 'Missing Environment' )
      end
      it 'does not complain when present' do
        subject.environment = 'production'
        lambda {
          subject.assert_environment
        }.should_not raise_error( ArgumentError, 'Missing Environment' )
      end
    end

    ########################################################################
    describe '#clear_environment' do
      it 'cleans environment' do
        subject.environment = 'test'
        subject.clear_environment
        lambda {
          subject.assert_environment
        }.should raise_error( ArgumentError, 'Missing Environment' )
      end
    end

    before(:each) do subject.clear_environment end

    ########################################################################
    USING_SETUP = {
      'explicit assignment' => [ :production,  lambda {
        Ghaki::Env::Engine.instance.environment  = 'production'
      }],
      'ENV[GHAKI_RUN_ENV]'  => [ :development, lambda { ENV['GHAKI_RUN_ENV'] = 'development' }],
      'ENV[RAILS_ENV]'      => [ :development, lambda { ENV['RAILS_ENV']     = 'development' }],
      'ENV[RACK_ENV]'       => [ :test,        lambda { ENV['RACK_ENV']      = 'test' }],
      'RAILS_ENV'           => [ :development, lambda { ::RAILS_ENV          = 'development' }],
      'Merb'                => [ :production,  lambda {
        Object::const_set( :Merb, Class::new )
        ::Merb.expects(:environment).returns('production')
      }],
      'Sinatra'             => [ :test,        lambda {
        Object::const_set( :Sinatra, Class::new )
        ::Sinatra.expects(:environment).returns('test')
      }],
    }

    ########################################################################
    describe '#detect_environment' do
      USING_SETUP.each_key do |desc|
        want,func = USING_SETUP[desc]
        it "detects #{desc}" do
          func.call
          subject.detect_environment.should == want
        end
      end
    end

    ########################################################################
    describe '#environment' do
      USING_SETUP.each_key do |desc|
        want,func = USING_SETUP[desc]
        it "accepts #{desc}" do
          func.call
          subject.environment.should == want
        end
      end
    end

  end
end end end
