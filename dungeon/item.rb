# class Item
#   attr_accessor :name, :type, :attack, :armor, :wearloc, :weight, :price
#   def initialize(name, type, attack, armor, wearloc, weight, price)
#     @name = name
#     @type = type
#     @attack = attack
#     @armor = armor
#     @wearloc = wearloc
#     @weight = weight
#     @price = price
#   end
# end

class Item
  attr_accessor :name, :type, :attack, :armor, :wearloc, :weight, :price
  def initialize(object)
    @name = object['name']
    @type = object['type']
    @attack = object['attack']
    @armor = object['armor']
    @wearloc = object['wearloc']
    @weight = object['weight']
    @price = object['price']
  end
end
