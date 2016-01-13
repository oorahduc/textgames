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

# class Item
#   attr_accessor :name, :type, :attack, :armor, :wearloc, :weight, :price
#   def initialize(object)
#     @name = object['name']
#     @type = object['type']
#     @attack = object['attack']
#     @armor = object['armor']
#     @wearloc = object['wearloc']
#     @weight = object['weight']
#     @price = object['price']
#   end
# end


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
