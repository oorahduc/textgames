#!/usr/bin/ruby -v

class Avatar

  MAX_HP = 300


  attr_accessor :stats, :inventory, :health, :maxhealth, :showstats
  def initialize(name, starting_location)
    @name = name
    MAX_HP = 300
    @current_room = starting_location
    # @player_attributes = {:current_hp => 100, :max_hp => 100}
    @player_name = "Chris"
    @stats = { :current_hp => 300, :max_hp => MAX_HP }
    @health = @stats[:current_hp]
    @maxhealth = @stats[:max_hp]
    @inventory = { :inventory => [] }
  end

  private
  def attributes(BASE_STATS)
    @stats = { :str => BASE_STATS[:str], :end => 10 }
    @attr = { :current_hp => 300, }
  end

  def stat
    attributes

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

# sword = Sword.new("heavy broadsword", "large")
# puts sword.shortname
# puts sword.longname
puts sword.wearloc
