class Room
  attr_accessor :description, :rooms, :info, :handle
  attr_writer :starting_location
  attr_reader :avatar

  attr_accessor :objects
  def initialize
    @objects = []
  end

  def has_room_to_the?(direction)
    rooms.key?(direction)
  end

  def display_room
    puts description.blue, info.gray
    puts listobjects
    puts exits.brown
  end

  attr_accessor :listobjects
  def listobjects
    # puts @objects
    if @objects.empty? == false
      @objects.each { |obj| puts "#{obj.name} lies on the ground." }
    else
      return ""
    end
    nil
  end

  def exits
    print "Exits: "
    rooms.keys.join(" ")
  end

  attr_accessor :additem
  def additem(item)
    @objects << item
    # puts @objects.class
    nil
  end

  attr_accessor :delitem
  def delitem(item)
    @objects.delete(item)
  end

  def starting_location?
    @starting_location
  end
end

# class RoomObjects
#   attr_accessor :contents
#   def initialize
#     @contents = []
#   end

#   attr_accessor :put
#   def put(item)
#     @contents << item
#   end

#   attr_accessor :remove
#   def remove(item)
#     @contents.delete(item)
#   end
# end
