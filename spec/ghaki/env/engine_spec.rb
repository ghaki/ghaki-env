############################################################################
require 'ghaki/env/engine'
require 'mocha_helper'

############################################################################
module Ghaki module Env module EngineTesting
  describe Ghaki::Env::Engine do

    ########################################################################
    subject { Ghaki::Env::Engine.instance }
    context 'singleton' do
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
      it 'should complain when missing' do
        lambda {
          subject.assert_environment
        }.should raise_error( ArgumentError, 'Missing Environment' )
      end
      it 'should not complain when present' do
        subject.environment = 'production'
        lambda {
          subject.assert_environment
        }.should_not raise_error( ArgumentError, 'Missing Environment' )
      end
    end

    ########################################################################
    describe '#clear_environment' do
      it 'should clean environment' do
        subject.environment = 'test'
        subject.clear_environment
        lambda {
          subject.assert_environment
        }.should raise_error( ArgumentError, 'Missing Environment' )
      end
    end

    before(:each) do subject.clear_environment end

    ########################################################################
    describe 'using explicit assignment' do
      before(:each) do
        subject.environment = 'production'
      end
      it '#detect_environment' do subject.detect_environment.should == :production end
      it '#environment'        do subject.environment.should        == :production end
    end

    ########################################################################
    context 'using ENV[GHAKI_RUN_ENV]' do
      before(:each) do
        ENV['GHAKI_RUN_ENV'] = 'development'
      end
      it '#detect_environment' do subject.detect_environment.should == :development end
      it '#environment'        do subject.environment.should        == :development end
    end

    ########################################################################
    context 'using ENV[RAILS_ENV]' do
      before(:each) do
        ENV['RAILS_ENV'] = 'development'
      end
      it '#detect_environment' do subject.detect_environment.should == :development end
      it '#environment'        do subject.environment.should        == :development end
    end

    ########################################################################
    context 'using ENV[RACK_ENV]' do
      before(:each) do
        ENV['RACK_ENV'] = 'test'
      end
      it '#detect_environment' do subject.detect_environment.should == :test end
      it '#environment'        do subject.environment.should        == :test end
    end

    ########################################################################
    context 'using RAILS_ENV' do
      before(:each) do
        ::RAILS_ENV = 'development'
      end
      it '#detect_environment' do subject.detect_environment.should == :development end
      it '#environment'        do subject.environment.should        == :development end
    end

    ########################################################################
    context 'using Merb' do
      before(:each) do
        if not defined? ::Merb
          class ::Merb
            def environment ; return 'test' end
          end
        end
        ::Merb.expects(:environment).returns('production')
      end
      it '#detect_environment' do subject.detect_environment.should == :production end
      it '#environment'        do subject.environment.should        == :production end
    end


    ########################################################################
    context 'using Sinatra' do
      before(:each) do
        if not defined? ::Sinatra
          class ::Sinatra
            def environment; return 'test' end
          end
        end
        ::Sinatra.expects(:environment).returns('test')
      end
      it '#detect_environment' do subject.detect_environment.should == :test end
      it '#environment'        do subject.environment.should        == :test end
    end


  end
end end end
############################################################################
