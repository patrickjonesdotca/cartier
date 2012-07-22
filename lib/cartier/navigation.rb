module Cartier

  # Encapsulating class for Navigation calculations
  class Navigation
    #radius in km
    EARTH_RADIUS = 6371
    
    #
    #
    # * *Args*    :
    #   - +location+ -> GPSLocation object representing current location
    #   - +longitude+ -> GPSLocation object representing current destination
    # * *Returns* :
    #   - distance in km   
    def self.haversine_distance(location, destination)
      delta_lat = (destination.latitude.to_f - location.latitude.to_f) * Math::PI/180
      delta_long = (destination.longitude.to_f - location.longitude.to_f) * Math::PI/180
    
      latitude_1 = (location.latitude.to_f) * Math::PI/180
      latitude_2 = (destination.latitude.to_f) * Math::PI/180
    
      a = Math.sin(delta_lat/2)**2 + Math.sin(delta_long/2)**2 * Math.cos(latitude_1) * Math.cos(latitude_2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      EARTH_RADIUS * c  
    end
    
     #
    #
    # * *Args*    :
    #   - +location+ -> GPSLocation object representing current location
    #   - +longitude+ -> GPSLocation object representing current destination
    # * *Returns* :
    #   - distance in km 
    def self.equirectangular_projection(location, destination)
      latitude_1 = (location.latitude.to_f) * Math::PI/180
      latitude_2 = (destination.latitude.to_f) * Math::PI/180
      
      longitude_1 = (location.longitude.to_f) * Math::PI/180
      longitude_2 = (destination.longitude.to_f) * Math::PI/180
      
      x = (longitude_2 - longitude_1) * Math.cos((latitude_1+latitude_2)/2)
      y = latitude_2 - latitude_1
      Math.sqrt(x*x + y*y) * EARTH_RADIUS
    end
    
    #
    #
    # * *Args*    :
    #   - +location_here+ -> GPSLocation object representing current location
    #   - +array_of_locations+ -> an Array of GPSLocation objects
    # * *Returns* :
    #   - GPSLocation object representing closest location
    #
    def self.closest_point(location_here, array_of_locations=nil)
      array_of_locations.sort do |a, b| 
        self.haversine_distance(location_here, a) <=> self.haversine_distance(location_here, b) 
      end.first
    end
    
    #
    #
    # * *Args*    :
    #   - +location+ -> GPSLocation object representing current location
    #   - +destination+ -> GPSLocation object representing destination
    # * *Returns* :
    #   - Bearing in Degrees (not radians)
    #
    def self.get_bearing(location, destination)
      location_long = location.longitude.to_f
      location_latitude = location.latitude.to_f
      destination_long = destination.longitude.to_f
      destination_latitude = destination.latitude.to_f
      
      delta_long = (destination_long - location_long)
      y = Math.sin(delta_long) * Math.cos(destination_latitude)
      x = Math.cos(location_latitude) * Math.sin(destination_latitude) - Math.sin(location_latitude) * Math.cos(destination_latitude) * Math.cos(delta_long)
      theta = (Math.atan2(y, x) / Math::PI) * 180
      (theta + 360) % 360
    end
    
  end
end