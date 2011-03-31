############################################################################
require 'ghaki/env/mixin'

############################################################################
module Ghaki module Env module MixinTesting
  describe Ghaki::Env::Mixin do

    ########################################################################
    class TestEnv
      include Ghaki::Env::Mixin
    end

    context 'object' do
      subject { TestEnv.new }
      it { should respond_to :environment }
      it { should respond_to :environment= }
      it { should respond_to :assert_environment }
      it { should respond_to :clear_environment }
      it { should respond_to :detect_environment }
    end

  end
end end end
############################################################################
