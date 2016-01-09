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
