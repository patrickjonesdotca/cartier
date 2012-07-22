module Cartier

  # Encapsulating class for Navigation calculations
  class Navigation
    #radius in km
    EARTH_RADIUS = 6371
    RADIANS = 57.29578
    
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
      location_long = location.longitude.to_f * Math::PI/180
      location_latitude = location.latitude.to_f * Math::PI/180
      destination_long = destination.longitude.to_f
      destination_latitude = destination.latitude.to_f
      
      delta_long = (destination_long - location_long) * Math::PI/180
      y = Math.sin(delta_long) * Math.cos(destination_latitude)
      x = Math.cos(location_latitude) * Math.sin(destination_latitude) - Math.sin(location_latitude) * Math.cos(destination_latitude) * Math.cos(delta_long)
      theta = (Math.atan2(y, x) / Math::PI) * 180
      (theta + 360) % 360
    end
    
    
    #
    #
    # * *Args*    :
    #   - +location+ -> GPSLocation object representing current location
    #   - +destination+ -> GPSLocation object representing destination
    # * *Returns* :
    #   - Cartier::GPSLocation object representing midpoint
    #
    def self.get_midpoint(location, destination)
      latitude_1 = location.latitude.to_f * Math::PI/180
      longitude_1 = location.longitude.to_f * Math::PI/180
      latitude_2 = destination.latitude.to_f * Math::PI/180
      delta_long = (destination.longitude.to_f - location.longitude.to_f) * Math::PI/180
      
      bx = Math.cos(latitude_2) * Math.cos(delta_long)
      by = Math.cos(latitude_2) * Math.sin(delta_long)

      latitude_3 = Math.atan2(Math.sin(latitude_1) + Math.sin(latitude_2), 
        Math.sqrt( (Math.cos(latitude_1)+bx)*(Math.cos(latitude_1)+bx) + by*by))
      longitude_3 = longitude_1 + Math.atan2(by, Math.cos(latitude_1) + bx)
      longitude_3 = (longitude_3+3*Math::PI) % (2*Math::PI) - Math::PI
      
      latitude_3 = latitude_3 * RADIANS
      longitude_3 = longitude_3 * RADIANS
      Cartier::GPSLocation.new(latitude_3.to_s, longitude_3.to_s)
    end
    
    #
    #
    # * *Args*    :
    #   - +location+ -> Cartier::GPSLocation
    #   - +bearing+ -> Bearing in Degrees
    #   - +distance+ -> Distance in km
    # * *Returns* :
    #   - Cartier::GPSLocation object representing final point
    #
    def self.get_destination_point(location, bearing, distance)
      distance_in_radians = distance / EARTH_RADIUS
      bearing_in_radians = bearing * Math::PI/180
      
      latitude_1 = location.latitude.to_f * Math::PI/180
      longitude_1 = location.longitude.to_f * Math::PI/180
      
      latitude_2 = Math.asin( Math.sin(latitude_1)*Math.cos(distance_in_radians) + 
                        Math.cos(latitude_1)*Math.sin(distance_in_radians)*Math.cos(bearing_in_radians) )
      longitude_2 = longitude_1 + Math.atan2(Math.sin(bearing_in_radians)*Math.sin(distance_in_radians)*Math.cos(latitude_1), 
                               Math.cos(distance_in_radians)-Math.sin(latitude_1)*Math.sin(latitude_2))
      longitude_2 = (longitude_2+3*Math::PI) % (2*Math::PI) - Math::PI
      latitude_2 = latitude_2 * RADIANS
      longitude_2 = longitude_2 * RADIANS
      Cartier::GPSLocation.new(latitude_2.to_s, longitude_2.to_s)
    end
    
  end
end