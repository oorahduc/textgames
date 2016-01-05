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
    item = get_item
    # puts item_data
    item.id = item_data["id"]
    item.shortname = item_data["shortname"]
    item.desc = item_data["desc"]
    item.weight = item_data["weight"]
    item.type = item_data["type"]
    item.wearloc = item_data["wearloc"]
    item.playeraffects = item_data["playeraffects"]
    item
  end

  def build_room(room_data)
    room = get_room
    room.handle = room_data["handle"]
    room.description = room_data["desc"]
    room.info = room_data["info"]
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
