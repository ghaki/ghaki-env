require 'ghaki/env/engine'
require 'forwardable'

module Ghaki #:nodoc:
module Env   #:nodoc:

  # Extends class with environment methods delegated to the environment singleton.

  module Mixin
    extend Forwardable

    def_delegators 'Ghaki::Env::Engine.instance',
      :environment,:environment=,:clear_environment,
      :assert_environment,:detect_environment

  end

end end
