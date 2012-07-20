require 'factory_girl'

FactoryGirl.define do
  
  factory :cn_tower, class: Cartier::GPSLocation do |f|
    f.latitude  "43.64775237227008"
    f.longitude "-79.38707828521729"
  end
  
  factory :ago, class: Cartier::GPSLocation do
    latitude "43.653476"
    longitude "-79.392686"
  end
  
  factory :washington_monument, class: Cartier::GPSLocation do
    latitude "38.89514125082739"
    longitude "-77.03527450561523"
  end
  
  factory :union_station, class: Cartier::GPSLocation do
    latitude "38.897102"
    longitude "-77.006355"
  end
  
end