class Item
	attr_accessor :id, :shortname, :desc, :weight, :type, :wearloc, :playeraffects
  attr_reader :avatar

	def has_room_to_the?(direction)
		rooms.key?(direction)
	end

  def list
    items.inspect
  end

  def display_room
    puts description.blue, info.gray
    puts exits.brown
  end

  def exits
    print "Exits: "; rooms.keys.join(" ")
  end

end
