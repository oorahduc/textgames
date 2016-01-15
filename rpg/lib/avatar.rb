require File.join(File.expand_path(File.dirname(__FILE__)), 'inventory')
require File.join(File.expand_path(File.dirname(__FILE__)), 'equipment')
require File.join(File.expand_path(File.dirname(__FILE__)), 'combat')
require File.join(File.expand_path(File.dirname(__FILE__)), 'util')

class Avatar
  include Combat
  include Equipment
  attr_accessor :avatar_name, :name
  def initialize(name, starting_location)
    @current_room = starting_location
    @avatar_name = name
    @name = @avatar_name
    @hitpoints = 300
    @maxhitpoints = 300
    @base_attack = rand(5..10)

    @affects = []
    @avatar_attr = [:str => rand(7..22), :end => rand(7..22)]

    @inventory = Inventory.new
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
    @breastplate = Item.new({'name' => 'a mithril breastplate', 'type' => 'armor', 'attack' => 0, 'armor' => 15, 'wearloc' => 'torso', 'weight' => 18, 'price' => 30})

    @inventory.additem(@broadsword)
    @inventory.additem(@breastplate)

  end

  # Avatar's current location
  def location
    @current_room
  end

  # Confirm Avatar can move in a particular direction
  def can_move?(direction)
    @current_room.has_room_to_the?(direction)
  end

  # Avatar Method to move avatar in a direction, to a new room
  def move(direction)
    if can_move?(direction)
      new_room = @current_room.rooms[direction]
      @current_room = new_room
      location.eval_action
      true
    else
      false
    end
  end

  # Avatar Method to look at npc
  def look_at_npc(tokens)
    @npc = tokens[2]
    @current_room.npcs.map do |n|
      if n.name.include?(@npc)
      puts n.desc.magenta

        # Compare avatar/npc attack value
        if @base_attack > n.attack
          @disp_set = "weaker than"
        elsif @base_attack.between(n.attack - 1, n.attack + 1)
          @disp_set = "about the same"
        elsif @base_attack < n.attack
          @disp_set = "stronger than"
        end

      puts "The #{n.name} looks #{@disp_set} you."

      end
    end
  end

  def interact(object, action)
    @target = object
    @object.action
  end

  attr_accessor :stats
  def stats
    puts "You are #{@avatar_name}."
    puts "You have #{@avatar_attr[:str]} strength and #{@avatar_attr[:end]} endurance."
    puts "You have #{hitpoints} hitpoints"
  end

  # Avatar Method to wear item by matched keyword
  attr_accessor :wear_item
  def wear_item(keyword)
    begin
      @inventory.contents.map{|x| @equipment.worn[x.wearloc] = x and @inventory.contents.delete(x) and puts "You equipped #{x.name}." if x.name.include?(keyword)}
    rescue
      puts "You don't have that."
    end
  end

  # Avatar Method to remove item by matched keyword
  attr_accessor :remove_item
  def remove_item(keyword)
    begin
      @equipment.worn.map.each { |x| o = x[1] and @inventory.contents << o and @equipment.worn.delete(o.wearloc) and puts "You remove #{x[1].name}" if x[1].name.include?(keyword) }
    rescue
      puts "You aren't wearing that."
    end
  end

  # Avatar Method to drop item by matched keyword
  attr_accessor :dropitem
  def dropitem(keyword)
    begin
      @inventory.contents.map{|x| location.objects << x and @inventory.contents.delete(x) and puts "You drop #{x.name}." if x.name.include?(keyword)}
    rescue
      puts "You don't have that."
    end
  end

  # Avatar Method to get item by matched keyword
  attr_accessor :getitem
  def getitem(keyword)
    begin
      location.objects.map{|x| @inventory.contents << x and location.objects.delete(x) and puts "You pick up #{x.name}." if x.name.include?(keyword)}
    rescue
      puts "You don't see that."
    end
  end

  # def getitem(keyword)
  #   location.objects.map do |x|
  #     if x.name.include?(keyword)
  #       @inventory.contents << x
  #       location.objects.delete(x)
  #       puts "You pick up #{x.name}."
  #     end
  #   end
  # end

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

  attr_accessor :inventory
  def inventory
    @inventory
  end

  # Returns formatted list of affects on avatar
  # NEEDS TO BE IMPLEMENTED
  attr_accessor :affects
  def affects
    @affects.active
  end

end
