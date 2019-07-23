require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Install_tal do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ install_tal }).should.be.instance_of Command::Install_tal
      end
    end
  end
end

