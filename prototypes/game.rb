require './objectbuilder.rb'
require 'pp'

class Object
  def copy
    prototype = clone

    instance_variables.each do |ivar_name|
      prototype.instance_variable_set(
        ivar_name,
        instance_variable_get(ivar_name).clone)
    end

    prototype
  end
end

def Object(object=nil, &definition)
  obj = object || Object.new
  obj.singleton_class.instance_exec(ObjectBuilder.new(obj), &definition)
  obj
end

end_of_road = Object { |o|
  o.description = <<END
You are standing at the end of a road before a small brick building.
Around you is a forest.  A small stream flows out of the building and
down a gully.
END
  # o.exits = {north: wellhouse}
}

wellhouse = Object { |o|
  o.description = <<END
You are inside a small building, a wellhouse for a large spring.
END
}


Object(end_of_road) { |o| o.exits = {north: wellhouse} }
Object(wellhouse) { |o| o.exits = {south: end_of_road} }


adventurer = Object { |o|
  o.location = end_of_road

  attr_writer :location

  o.look = ->(*args) {
    puts location.description
  }
}

adventurer.look

Object(adventurer) { |o|
  o.go = ->(direction){
    if(destination = location.exits[direction])
      self.location = destination
      puts location.description
    else
      puts "You can't go that way"
    end
  }
}

room = Object { |o| o.exits = {} }

hut = room.copy

hut.exits[:west] = end_of_road
hut.exits[:east] = end_of_road

print "exits: "
puts hut.exits.keys.join(" ")


# adventurer.go(:north)
# adventurer.go(:south)
