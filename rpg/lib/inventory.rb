

class Inventory
  attr_accessor :contents
  def initialize
    @contents = []
  end

  attr_accessor :additem
  def additem(item)
    @contents << item
    nil
  end

  attr_accessor :listinventory
  def listinventory
    puts "Inventory".blue
    if @contents.empty?
      puts "Your inventory is empty."
    end
    @contents.sort_by {|i| i.type}.each do |item|
      puts "#{item.name} (#{item.type})"
    end
    nil
  end

  attr_accessor :inventory
  def inventory
    @contents.sort_by {|i| i.type}.each do |item|
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
    @contents.each { |item|
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
    @contents.each { |item|
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
  attr_accessor :worn, :equipped, :possible_wearlocs
  def initialize
    @worn = Hash.new
    @possible_wearlocs = ["head", "torso", "finger", "wielding"]
  end

  def equipped
    puts "Equipment:".blue
    if @worn.empty?
      puts "You are wearing nothing."
    end
    @worn.each do |key, val|
      if val.wearloc == "wielding"
        puts "You are wielding #{val.name.red}."
      else
        puts "You are wearing #{val.name.cyan} on your #{val.wearloc}."
      end
    end
  end

end

# player = Player.new('Chris')
# puts player.showinventory
# puts player.equipped
# player.wear_item("broadsword")
# player.wear_item("ring")
# player.wear_item("breastplate")
# puts player.showinventory
# puts player.equipped
