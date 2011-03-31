require 'singleton'

module Ghaki #:nodoc:
module Env   #:nodoc:

  # Run time environment discovery singleton.
  #
  # - Detects GHAKI_RUN_ENV, RAILS_ENV, RACK_ENV in environment.
  # - Detects the RAILS_ENV global constant.
  # - Detects Sinatra and Merb classes in the Ruby namespace.
  #
  # ==== Examples
  #
  #    Ghaki::Env.instance.clear_environment
  #    RACK_ENV = 'testing'
  #    Ghaki::Env.instance.environment        #=> 'testing'

  class Engine
    include Singleton

    # Environment read attribute, detects current environment if not already set.

    def environment
      @environment ||= self.detect_environment
    end

    # Environment write attribute. Asserts on acceptable values.

    def environment= val
      @environment = _assert_environment( val )
    end

    # Clears current set environment.

    def clear_environment
      @environment = nil
    end

    # Throw an exception if the environment is not valid.

    def assert_environment
      _assert_environment( @environment )
    end

    # Check environment for current run state.

    def detect_environment
      _assert_environment( self._detect_environment )
    end

    protected

    def _assert_environment val #:nodoc:
      case val
      when nil
        raise ArgumentError, 'Missing Environment'
      when :production, :prod, 'production', 'prod'
        :production
      when :devel, :development, :dev, 'devel', 'development', 'dev'
        :development
      when :test, :testing, 'test', 'testing'
        :test
      else
        raise ArgumentError, "Invalid Environment Name: #{val}"
      end
    end

    def _detect_environment #:nodoc:
      if not @environment.nil?
        @environment
      elsif ENV.has_key?('GHAKI_RUN_ENV')
        ENV['GHAKI_RUN_ENV']
      elsif ENV.has_key?('RACK_ENV')
        ENV['RACK_ENV']
      elsif defined?(RAILS_ENV)
        RAILS_ENV
      elsif ENV.has_key?('RAILS_ENV') # deprecated
        ENV['RAILS_ENV']
      elsif defined?(Sinatra)
        Sinatra.environment
      elsif defined?(Merb)
        Merb.environment
      else
        nil
      end
    end

  end

end end 
