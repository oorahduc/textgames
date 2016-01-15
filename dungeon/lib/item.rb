class Item
  TYPES = [:potion, :sword]

  attr_accessor :type

  def initialize
    @type = TYPES.sample
  end

  def interact(player)
    case @type
    when :potion
      puts "You pick up #{self}."
      player.heal(10)
    when :sword
      puts "You pick up #{self}."
      player.attack_power += 1
    end
  end

  def to_s
    "a shiny awesome #{@type.to_s}"
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

class Sword < Item
  def initialize
    @name = "sword"
  end

  def perform_item_effect(player)
    player.attack_power += 1
  end
end
