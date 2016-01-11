require File.join(File.dirname(__FILE__), 'room')
require File.join(File.dirname(__FILE__), 'item')
require 'yaml'

class GameDataLoader
  def load_location_data(file)
    data = load_yaml(file)
    rooms = load_initial_state(data)
    establish_relationships(rooms)
    rooms
  end

  def load_item_data(file)
    data = load_yaml(file)
    items = load_initial_itemstate(data)
    # establish_relationships(items)
    items
  end

  def load_message_data(file)
    load_yaml(file)
  end

  def load_initial_itemstate(data)
    items = []
    data.each {|item_data| items << build_item(item_data)}
    items
  end

  def load_initial_state(data)
    rooms = []
    data.each {|room_data| rooms << build_room(room_data)}
    rooms
  end

  def establish_relationships(all_rooms)
    all_rooms.each do |room|
      room.rooms.each do |direction, handle|
        room.rooms[direction] = all_rooms.find {|r| r.handle == handle}
      end
    end
  end

def build_item(item_data)
  puts item_data
  # item = get_item
  item = Item.new(item_data)
  # item.name = item_data['name']
  # item.type = item_data['type']
  # item.attack = item_data['attack']
  # item.armor = item_data['armor']
  # item.wearloc = item_data['wearloc']
  # item.weight = item_data['weight']
  # item.price = item_data['price']
  item
end

  def build_room(room_data)
    room = get_room
    room.handle = room_data["handle"]
    room.description = room_data["desc"]
    room.info = room_data["info"]
    room.objects = []
    if room_data["objects"]
      room_data["objects"].each do |obj|
        thisobj = Hash[obj[1]]
        puts thisobj.class
        puts thisobj

        room.objects << build_item(thisobj)
        # tmpobj = Hash.new
        # tmpobj = obj[1]
        # puts tmpobj.class
        # puts tmpobj.inspect
        # build_item(tmpobj.to_s)
        # # puts tmpobj
      end
      # room.objects = room_data["objects"].each do |obj|
      #   # obj.delete(obj[0])
      #   # puts obj
      #   @buildobjs = Array.new
      #   @buildobjs << obj[1].to_a
      #   # puts obj
      #   puts @buildobjs.inspect
      #   # @buildobjs.each {|i| build_item(i)}
      # end
    # puts @buildobjs
    # if room_data["objects"]
    #   room.objects = room_data["objects"].each {|obj| build_item(obj)}
    elsif !room_data["objects"]
      room.objects = []
    end
    room.rooms = room_data["rooms"]
    room.starting_location = room_data["starting_location"]
    room
  end

  private
  def get_room
    Room.new
  end

  private
  def get_item
    Item.new
  end

  def load_yaml(file)
    YAML.load_file(file)
  end

end
