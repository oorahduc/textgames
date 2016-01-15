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

  attr_accessor :delitem
  def delitem(item)
    @contents.delete(item)
    nil
  end

  attr_accessor :listinventory
  def listinventory
    puts "Inventory".blue
    if @contents.empty?
      puts "Your inventory is empty."
    else
      @contents.sort_by {|i| i.type}.each do |item|
        puts "#{item.name} (#{item.type})"
      end
    end
    nil
  end

  attr_accessor :exam_inventory
  def exam_inventory
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

