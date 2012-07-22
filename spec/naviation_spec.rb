require 'spec_helper'
require 'factories/location_factory'

include Cartier

describe Cartier::Navigation do
  it ".haversine_distance to self should be 0.0" do
    @location = FactoryGirl.build(:cn_tower)
    Cartier::Navigation.haversine_distance(@location, @location).should == 0.0
  end
  
  it ".haversine_distance to washington monument should not be zero" do
    @cn_tower = FactoryGirl.build(:cn_tower)
    @washington_monument = FactoryGirl.build(:washington_monument)
    Cartier::Navigation.haversine_distance(@cn_tower, @washington_monument).should == 563.7658958719776
  end
  
  it ".equirectangular_projection to self should be 0.0" do
    @location = FactoryGirl.build(:cn_tower)
    Cartier::Navigation.equirectangular_projection(@location, @location).should == 0.0
  end
  
  it ".equirectangular_projection to washington monument should not be zero" do
    @cn_tower = FactoryGirl.build(:cn_tower)
    @washington_monument = FactoryGirl.build(:washington_monument)
    Cartier::Navigation.equirectangular_projection(@cn_tower, @washington_monument).should == 563.8330522056333
  end
  
  it ".closest_point should find the closest point" do
    @here = FactoryGirl.build(:cn_tower)
    @ago = FactoryGirl.build(:ago)
    @washington_monument = FactoryGirl.build(:washington_monument)
    Cartier::Navigation.closest_point(@here, [@ago, @washington_monument]).should == @ago
  end
  
  it ".get_bearing should calculate the bearing between cn_tower and ago properly" do
    @here = FactoryGirl.build(:cn_tower)
    @ago = FactoryGirl.build(:ago)
    Cartier::Navigation.get_bearing(@here, @ago).should == 317.1371597378672
  end
  
end