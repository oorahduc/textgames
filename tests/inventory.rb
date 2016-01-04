require 'yaml'

class Avatar

  MAX_HP = 300

  attr_accessor :stats, :attr, :inventory, :health, :maxhealth

  ##### THIS IS WRONG. REMEMBER SINGLE RESPONSIBILITY
  def initialize(name)
    @name = name
    @MAX_HP = 300
    # @player_attributes = {:current_hp => 100, :max_hp => 100}
    @player_name = "Chris"
    @stats = { :current_hp => 300, :max_hp => MAX_HP }
    @health = @stats[:current_hp]
    @maxhealth = @stats[:max_hp]
    @inventory = []
  end

  private
  def base_attributes
    @base_stats = { :str => 10, :end => 10 }
    @base_attr = { :current_hp => 300, :max_hp => 300 }
  end

  def attributes
    @stats = base_attributes["base_stats"]
    @attr = base_attributes["base_attr"]
  end

  private
  def health
    300
  end

  def heal(value)
    health += value
    puts "Healed for #{value}."
  end

  def damage(value)
    health -= value
    puts "Damaged for #{value}."
  end

  def stats
    puts "You have #{health} hitpoints."
  end

end

player = Avatar.new("Chris")
# puts player.attributes

puts player.inspect


# inventory = YAML.load_file('inventory.yml')
# puts inventory.inspect
# puts
# puts inventory[1]
