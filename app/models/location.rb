class Location < ActiveRecord::Base
	geocoded_by :address   # can also be an IP address
	after_validation :geocode    # auto-fetch coordinates

	def self.sumanth
		location = Location.all
		hash = {}
		for i in (0..location.length-1)
      		for j in ((i+1)..(location.length-1))
         		puts "Distance between" +" " +location[i][:address] + "and" +" " +location[j][:address] + "is"
         		value = Geocoder::Calculations.distance_between([location[i][:latitude],location[i][:longitude]] , [location[j][:latitude] , location[j][:longitude]]).round(2)
         		puts value 
         		key = location[i][:address]+" "+"and"+" "+location[j][:address]
         		hash[key] = value
      		end
    	end
    	least = [hash.min_by{|k, v| v}].to_h
    	distance = least.values[0]
    	city = least.keys[0]
    	return city,distance
	end 
end
