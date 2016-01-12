require File.join(File.expand_path(File.dirname(__FILE__)), 'inventory')
require File.join(File.expand_path(File.dirname(__FILE__)), 'equipment')
require File.join(File.expand_path(File.dirname(__FILE__)), 'util')

class Avatar
  attr_accessor :avatar_name
  def initialize(name, starting_location)
    @current_room = starting_location
    @avatar_name = name
    @hitpoints = 300
    @maxhitpoints = 300

    @inventory = Inventory.new
    @affects = []

    @equipment = Equipment.new
  end


  # Debug item creation method
  attr_accessor :createtestitems
  def createtestitems
    # @broadsword = Item.new('a heavy broadsword', 'weapon', 5, 0, 'wielding', 15, 2)
    # @breastplate = Item.new('a mithril breastplate', 'armor', 0, 10, 'torso', 15, 5)
    # @ring = Item.new('a gold ring', 'armor', 0, 3, 'finger', 2, 20)
    # @dagger = Item.new('a dagger', 'weapon', 3, 0, 'wielding', 5, 2)
    @broadsword = Item.new({'name' => 'a heavy broadsword', 'type' => 'weapon', 'attack' => 5, 'armor' => 0, 'wearloc' => 'wielding', 'weight' => 15, 'price' => 2})
    # @breastplate = Item.new('a mithril breastplate', 'armor', 0, 10, 'torso', 15, 5)
    # @ring = Item.new('a gold ring', 'armor', 0, 3, 'finger', 2, 20)
    # @dagger = Item.new('a dagger', 'weapon', 3, 0, 'wielding', 5, 2)
    puts @broadsword.inspect


    @inventory.additem(@broadsword)
    # @inventory.additem(@breastplate)
    # @inventory.additem(@ring)
    # @inventory.additem(@dagger)
    # @current_room.additem(@dagger)
    # @current_room.objects = []
    # puts @current_room.objects.class
  end


  def location
    @current_room
  end

  def can_move?(direction)
    @current_room.has_room_to_the?(direction)
  end

  def move(direction)
    if can_move?(direction)
      new_room = @current_room.rooms[direction]
      @current_room = new_room
      true
    else
      false
    end
  end

  attr_accessor :hitpoints
  def hitpoints
    @hitpoints
  end

  #
  attr_accessor :wear_item
  def wear_item(keyword)
    begin
      @inventory.contents.map{|x| @equipment.worn[x.wearloc] = x and @inventory.contents.delete(x) and puts "You equipped #{x.name}." if x.name.include?(keyword)}
    rescue
      puts "Huh?"
    end
  end

  #
  attr_accessor :remove_item
  def remove_item(keyword)
    begin
      @equipment.worn.map.each { |x| o = x[1] and @inventory.contents << o and @equipment.worn.delete(o.wearloc) if x[1].name.include?(keyword) }
      puts "Removed."
    rescue
      puts "Huh?"
    end
  end

  #
  attr_accessor :dropitem
  def dropitem(keyword)
    begin
      @inventory.contents.map{|x| location.objects << x if x.name.include?(keyword)}
    rescue
      puts "something happened at room put."
    end
    begin
      @inventory.contents.map{|x| @inventory.contents.delete(x) if x.name.include?(keyword)}
    rescue
      puts "You can't find it."
    end
  end

  #
  attr_accessor :getitem
  def getitem(keyword)
    begin
      location.objects.map{|x| @inventory.contents << x if x.name.include?(keyword)}
    rescue
      puts "something happened at room put."
    end
    begin
      location.objects.map{|x| location.objects.delete(x) if x.name.include?(keyword)}
    rescue
      puts "You can't find it."
    end
  end

  # Returns formatted list of worn equipment
  attr_accessor :equipped
  def equipped
    @equipment.equipped
    nil
  end

  # Returns formatted list of equipment in inventory
  attr_accessor :showinventory
  def showinventory
    @inventory.listinventory
  end

  # Returns formatted list of affects on avatar
  # NEEDS TO BE IMPLEMENTED
  attr_accessor :affects
  def affects
    @affects.active
  end

end
