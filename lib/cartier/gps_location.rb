module Cartier
  class GPSLocation
    attr_accessor :latitude, :longitude, :decimal_notation, :imperial
    #
    #
    # * *Args*    :
    #   - +latitude+ -> Latitude in Degree Notation (i.e. 37.0428759)
    #   - +longitude+ -> Longitude in Degree Notation (i.e. -79.0428759)
    #   - +decimal_notation+ -> Defaulting to true for now
    #   - +imperial+ -> Defaulting metric system
    # * *Returns* :
    #   - a GPSLocation object
    # * *Raises* :
    #  - ++ ->
    #
    def initialize(latitude=nil, longitude=nil, decimal_notation=true, imperial=false)
      self.latitude = latitude
      self.longitude = longitude
      self.decimal_notation = decimal_notation
      self.imperial = imperial
    end  
    
  end
end