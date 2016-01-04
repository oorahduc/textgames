class Room
	attr_accessor :description, :rooms, :items, :info, :handle, :roomexits
	attr_writer :starting_location
  attr_reader :avatar

	def has_room_to_the?(direction)
		rooms.key?(direction)
	end

  def roomexits
    rooms.keys
  end

  def display_room
    puts description.blue, info.gray
    puts exits.brown
  end

  def exits
    print "Exits: "; rooms.keys.join(" ")
  end

	def starting_location?
		@starting_location
	end
end
