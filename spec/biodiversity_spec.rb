require 'spec_helper'

describe Biodiversity do
  it 'should have version' do
    version = Biodiversity::VERSION
    version.should =~ /^\d+\.\d+\.\d+/
    version.should == Biodiversity.version
  end
end
