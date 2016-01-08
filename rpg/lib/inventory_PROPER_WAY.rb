require '../lib/util.rb'

class Player
  attr_accessor :playername, :inventory
  def initialize(playername)
    @playername = playername
    @inventory = Inventory.new
    @affects = []

    @broadsword = Item.new('a heavy broadsword', 'weapon', 5, 0, 'wielding', 15, 2)
    @breastplate = Item.new('a mithril breastplate', 'armor', 0, 10, 'torso', 15, 5)
    @ring = Item.new('a gold ring', 'armor', 0, 3, 'finger', 2, 20)
    @dagger = Item.new('a dagger', 'weapon', 3, 0, 'wielding', 5, 2)

    @inventory.additem(@broadsword)
    @inventory.additem(@breastplate)
    @inventory.additem(@ring)
    @inventory.additem(@dagger)

    @equipment = Equipment.new
    @equipment.wear(@dagger)
    @equipment.wear(@ring)
  end

  def wear_item(item)
    if @inventory.include?(item)
      @equipment.wear(item)
    end
  end

  attr_accessor :remove_item
  def remove_item(item)
    if @equipped[item.wearloc].include?(item)
      @inventory.additem(item)
      @equipped.remove(item)
    else
      puts "You aren't wearing that."
    end
  end

  attr_accessor :equipped
  def equipped
    @equipment.equipped
  end

  attr_accessor :showinventory
  def showinventory
    @inventory.inventory
  end

  attr_accessor :affects
  def affects
    @affects.active
  end

end

class Inventory
  attr_accessor :items
  def initialize
    @items = []
  end

  attr_accessor :additem
  def additem(item)
    @items << item
  end

  attr_accessor :inventory
  def inventory
    @items.sort_by {|i| i.type}.each do |item|
      puts "#{item.name} (#{item.type})"
      if item.attack != nil ; puts " %-20s %00d" % ['Attack', item.attack] ; end
      if item.armor != nil ; puts " %-20s %00d" % ['Armor', item.armor] ; end
      if item.wearloc != nil ; puts " %-20s %00s" % ['Wear', item.wearloc] ; end
      if item.weight != nil ; puts " %-20s %00d" % ['Weight', item.weight] ; end
      if item.price != nil ; puts " %-20s %00d" % ['Price', item.price] ; end
    end
    nil
  end

  attr_accessor :showarmor
  def showarmor
    puts "Armor:"
    @items.each { |item|
      puts item.name if item.type == "armor"
      puts " %-20s %00d" % ['Attack', item.attack] unless item.type != "armor" || item.attack == 0
      puts " %-20s %00d" % ['Armor', item.armor] unless item.type != "armor" || item.armor == 0
      puts " %-20s %00s" % ['Wear', item.wearloc] unless item.type != "armor" || item.wearloc == 0
      puts " %-20s %00d" % ['Weight', item.weight] unless item.type != "armor" || item.weight == 0
      puts " %-20s %00d" % ['Price', item.price] unless item.type != "armor" || item.price == 0
    }

    nil
  end

  attr_accessor :showweapons
  def showweapons
    puts "Weapon:"
    @items.each { |item|
      puts item.name if item.type == "weapon"
      puts " %-20s %00d" % ['Attack', item.attack] unless item.type != "weapon" || item.attack == 0
      puts " %-20s %00d" % ['Armor', item.armor] unless item.type != "weapon" || item.armor == 0
      puts " %-20s %00s" % ['Wear', item.wearloc] unless item.type != "weapon" || item.wearloc == 0
      puts " %-20s %00d" % ['Weight', item.weight] unless item.type != "weapon" || item.weight == 0
      puts " %-20s %00d" % ['Price', item.price] unless item.type != "weapon" || item.price == 0
    }

    nil
  end
end

class Item
  attr_accessor :name, :type, :attack, :armor, :wearloc, :weight, :price
  def initialize(name, type, attack, armor, wearloc, weight, price)
    @name = name
    @type = type
    @attack = attack
    @armor = armor
    @wearloc = wearloc
    @weight = weight
    @price = price
  end
end

class Equipment
  attr_accessor :equipped, :wield
  def initialize
    @equipped = Hash.new
    @possible_wearlocs = ["head", "torso", "finger", "wielding"]
  end

  attr_accessor :wear
  def wear(item)
    if @possible_wearlocs.include?(item.wearloc)
      @equipped[item.wearloc] = item
      puts @equipped
    else
      puts "Wear what where?"
    end
  end

  attr_accessor :remove
  def remove(item)
    if @equipped[item.wearloc].include?(item)
      puts "To be implemented"
    end
  end

end

player = Player.new('Chris')
# puts player.inventory
puts player.showinventory

puts player.equipped

# eq.worn["wielding"] = sword
# puts eq.worn
