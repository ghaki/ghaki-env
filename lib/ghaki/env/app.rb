require 'ghaki/app/engine'
require 'ghaki/env/mixin'

# Adds environment plugin to the app engine.

module Ghaki #:nodoc:
module App   #:nodoc:

  class Engine #:nodoc:
    include Ghaki::Env::Mixin
  end

end end
