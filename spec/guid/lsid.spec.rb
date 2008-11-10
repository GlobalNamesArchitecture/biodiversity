dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require File.expand_path(dir + "../../conf/environment")
require File.expand_path(dir + "../../lib/biodiversity/guid")

describe LsidResolver do   
  it "should return RFD document from lsid" do
    lsid = "urn:lsid:ubio.org:classificationbank:2232671"
    LsidResolver.resolve(lsid).class.should == "".class
  end
end
