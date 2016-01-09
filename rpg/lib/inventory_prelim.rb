require './rpg/lib/util.rb'

class Player
  attr_accessor :playername
  def initialize(playername)
    @playername = playername
  end
end

class Inventory < Player
  attr_accessor :items
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  attr_accessor :inventory
  def inventory
    #@items.each do |item|
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

  attr_accessor :showweapon
  def showweapon
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

class Item < Inventory
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

inv = Inventory.new
broadsword = Item.new('a heavy broadsword', 'weapon', 5, 0, 'wield', 15, 2)
breastplate = Item.new('a mithril breastplate', 'armor', 0, 10, 'torso', 15, 5)
ring = Item.new('a gold ring', 'armor', 0, 3, 'finger', 2, 20)
inv.add_item(broadsword)
inv.add_item(breastplate)
inv.add_item(ring)

player = Player.new('Chris')
# puts player.inventory
puts inv.inventory
puts inv.showarmor
puts inv.showweapon
