require 'spec_helper'
require 'factories/location_factory'

include Cartier

describe "Cartier::GPSLocation" do
  
  it "GPSLocation should build correctly" do
    @location = FactoryGirl.build(:cn_tower)
    @location.latitude.should ==  "43.64775237227008"
    @location.longitude.should == "-79.38707828521729"
  end
  
end