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

    @broadsword = Item.new('a heavy broadsword', 'weapon', 5, 0, 'wielding', 15, 2)
    @breastplate = Item.new('a mithril breastplate', 'armor', 0, 10, 'torso', 15, 5)
    @ring = Item.new('a gold ring', 'armor', 0, 3, 'finger', 2, 20)
    @dagger = Item.new('a dagger', 'weapon', 3, 0, 'wielding', 5, 2)

    @inventory.additem(@broadsword)
    @inventory.additem(@breastplate)
    @inventory.additem(@ring)

    @equipment = Equipment.new
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

  attr_accessor :wear_item
  def wear_item(keyword)
    @inventory.contents.map{|x| @equipment.worn[x.wearloc] = x and @inventory.contents.delete(x) if x.name.include?(keyword)}
  end

  # NEED TO FORMAT THIS ACCORDING TO WEAR_ITEM
  attr_accessor :remove_item
  def remove_item(item)
    if @equipment.equipped.include?(item)
      @inventory.additem(item)
      @equipment.worn.delete(item)
    else
      puts "You aren't wearing that."
    end
  end

  # NEED TO FORMAT THIS ACCORDING TO WEAR_ITEM
  # REWRITE ACCORDING TO FUZZY MATCHING FORMAT
  def dropitem(itemobject)
    if @inventory.include?(itemobject)

      # Temporarily save object to drop to the room.
      @tmp = itemobject

      # Pop item out of inventory
      @inventory.delete(itemobject)

      # Add item to room.
      @location.additem(itemobject) # ******** PSEUDO CODE
    else
      puts "You can't find it."
    end
  end

  # NEED TO FORMAT THIS ACCORDING TO WEAR_ITEM
  attr_accessor :getitem
  def getitem(keyword)
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

  # Avatar class call to damage avatar's hitpoints
  def damage(damage)
    @hitpoints -= damage
    puts "Ouch! #{damage} damage taken!"
    # dead?
  end

  # avatar class call to heal avatar's hitpoints
  def heal(healing)
    if healing >= @maxhitpoints - @hitpoints
      healing = @maxhitpoints - @hitpoints
      @hitpoints += healing
      puts "Yay! +#{healing} to health!"
    else
      @hitpoints += healing
      puts "Yay! +#{healing} to health!"
    end
  end

  # Check to see if avatar is dead.
  # May need to be moved to Combat module in the future.
  def dead?
    if @hitpoints <= 0
      puts "You DIED!!"
      exit
      # elsif @hitpoints > 0 then
      #   next
    end
  end

end
