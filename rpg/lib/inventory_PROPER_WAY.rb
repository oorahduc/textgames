require './util.rb'

class Player
  attr_accessor :playername, :showinventory
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
    # @inventory.additem(@dagger)

    @equipment = Equipment.new
  end

  attr_accessor :wear_item
  def wear_item(keyword)
    @inventory.contents.map{|x| @equipment.worn[x.wearloc] = x and @inventory.contents.delete(x) if x.name.include?(keyword)}
    # if @inventory.contents.include?(item)
    #   @inventory.contents.map{|x| @equipment.worn << x and @inventory.contents.delete(x) if x.name.include?(keyword) }
    # else
    #   puts "You don't have that."
    # end
  end

  attr_accessor :remove_item
  def remove_item(item)
    if @equipment.equipped.include?(item)
      @inventory.additem(item)
      @equipment.worn.delete(item)
    else
      puts "You aren't wearing that."
    end
  end

  attr_accessor :equipped
  def equipped
    @equipment.equipped
    # puts "Equipment:".blue
    # if @equipment.worn.empty?
    #   puts "You are wearing nothing."
    # end
    # @equipment.worn.each do |key, val|
    #   # puts "#{item.wearloc} : #{item.name}"
    #   if val.wearloc == "wielding"
    #     puts "You are wielding #{val.name.red}."
    #   else
    #     puts "You are wearing #{val.name.cyan} on your #{val.wearloc}."
    #   end
    # end

    nil
  end

  attr_accessor :showinventory
  def showinventory
    @inventory.listinventory
  end

  attr_accessor :affects
  def affects
    @affects.active
  end

end

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

  # attr_accessor :equipped
  # def equipped
  #   puts @equipped
    # @equipped.sort_by {|i| i.type}.each do |item|
    #   puts "#{item.name} (#{item.type})"
    #   if item.attack != nil ; puts " %-20s %00d" % ['Attack', item.attack] ; end
    #   if item.armor != nil ; puts " %-20s %00d" % ['Armor', item.armor] ; end
    #   if item.wearloc != nil ; puts " %-20s %00s" % ['Wear', item.wearloc] ; end
    #   if item.weight != nil ; puts " %-20s %00d" % ['Weight', item.weight] ; end
    #   if item.price != nil ; puts " %-20s %00d" % ['Price', item.price] ; end
    # end
  #   nil
  # end

  # attr_accessor :wear
  # def wear(item)
  #   if @possible_wearlocs.include?(item.wearloc)
  #     @worn[item.wearloc] = item
  #     puts @worn
  #   else
  #     puts "Wear what where?"
  #   end
  # end

end

player = Player.new('Chris')
# puts player.inventory
puts player.showinventory
puts player.equipped
player.wear_item("broadsword")
player.wear_item("ring")
player.wear_item("breastplate")
puts player.showinventory
puts player.equipped


# puts "Removing items"
# puts player.remove_item(@ring)
# puts player.remove_item(@dagger)
# puts "Inv/Eq"
# puts player.showinventory
# puts player.equipped

# eq.worn["wielding"] = sword
# puts eq.worn
