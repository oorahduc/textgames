class Room
  attr_accessor :description, :rooms, :items, :info, :handle
  attr_writer :starting_location
  attr_reader :avatar

  def initialize
    @roomitems = Roomitems.new
  end

  def has_room_to_the?(direction)
    rooms.key?(direction)
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

class Roomitems
  attr_accessor :contents
  def initialize
    @contents = []
  end

  attr_accessor :put
  def put(item)
    @contents << item
  end

  attr_accessor :remove
  def remove(item)
    @contents.delete(item)
  end
end
