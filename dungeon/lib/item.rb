class Item
  def interact(player)
    puts "You pick up #{self}"

    perform_item_effect(player)
  end

  def to_s
    "a shiny awesome #{@name}"
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
