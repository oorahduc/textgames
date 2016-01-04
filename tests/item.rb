#!/usr/bin/ruby -v

class Item
  def take(player)
    puts "You pick up #{self}"

    perform_item_effect(player)
  end
end

class Potion < Item
  def initialize
    @name = "potion"
  end

  def perform_item_effect(player)
    player.heal(10)
  end
end

class Weapon < Item
  @@wearable = true
  @@wearloc = ""
end

class Sword < Weapon
  attr_accessor :shortname, :longname, :size, :wearloc
  def initialize(shortname, size)
    @shortname = shortname
    @size = size

    if @@wearable == true
      @wearloc = @@wearloc
      @wearloc = "righthand"
    end
    @longname = "a #{@size} #{@shortname}"
  end

  def perform_item_effect(player)
    player.attack_power += 1
  end

  def to_s
    puts @longname
  end
end

sword = Sword.new("heavy broadsword", "large")
puts sword.shortname
puts sword.longname
puts sword.wearloc
