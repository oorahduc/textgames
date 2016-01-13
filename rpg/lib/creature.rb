require File.join(File.expand_path(File.dirname(__FILE__)), 'inventory')
require File.join(File.expand_path(File.dirname(__FILE__)), 'equipment')
require File.join(File.expand_path(File.dirname(__FILE__)), 'combat')
require File.join(File.expand_path(File.dirname(__FILE__)), 'util')

class Creature
  include Combat

  attr_accessor :creature_name
  def initialize(object)
    @current_room = starting_location
    @name = object['name']
    @attack = object['attack']
    @hitpoints = 300
    @maxhitpoints = 300

    @affects = []
    @creature_attr = {:str => 10, :end => 10}

    @inventory = Inventory.new
    @equipment = Equipment.new
  end

  # Creature's current location
  def location
    @current_room
  end

  attr_accessor :hitpoints
  def hitpoints
    @hitpoints
  end

  # Returns formatted list of affects on creature
  # NEEDS TO BE IMPLEMENTED
  attr_accessor :affects
  def affects
    @affects.active
  end

end
