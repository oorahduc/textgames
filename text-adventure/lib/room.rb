class Room
	attr_accessor :description, :rooms, :items, :info, :handle
	attr_writer :starting_location

	def has_room_to_the?(direction)
		rooms.key?(direction)
	end

  def exits
    rooms.keys
  end

  def listexits
    print "Exits: "
    rooms.keys.each { |exit| print exit + " " }
    print "\n"
  end

	def starting_location?
		@starting_location
	end
end
