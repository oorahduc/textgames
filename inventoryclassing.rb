require './rpg/lib/util.rb'

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

class Inventory
    attr_accessor :items
    def initialize
        @@items = []
    end

    def add_item(item)
        @@items << item
    end

    attr_accessor :inventory
    def inventory
        @@items.each do |item|
            puts "#{item.name} (#{item.type})"
            if item.attack != nil ; puts " %-20s %00d" % ['Attack', item.attack] ; end
            if item.armor != nil ; puts " %-20s %00d" % ['Armor', item.armor] ; end
            if item.wearloc != nil ; puts " %-20s %00s" % ['Wear', item.wearloc] ; end
            if item.weight != nil ; puts " %-20s %00d" % ['Weight', item.weight] ; end
            if item.price != nil ; puts " %-20s %00d" % ['Price', item.price] ; end
        end
    end
end

inv = Inventory.new
broadsword = Item.new('a heavy broadsword', 'weapon', 5, nil, 'wield', 15, 2)
breastplate = Item.new('a mithril breastplate', 'armor', nil, 10, 'torso', 15, 5)
ring = Item.new('a gold ring', 'armor', nil, 3, 'finger', 2, 20)
inv.add_item(broadsword)
inv.add_item(breastplate)
inv.add_item(ring)
# inv.to_s

class Player < Inventory
    attr_accessor :playername
    def initialize(playername)
        @playername = playername
    end
end

player = Player.new('Chris')
puts player.inventory



########
### Collections.namedtuple example
###

from collections import namedtuple

Item = namedtuple('Item', ('attack', 'defence', 'weight', 'price'))
inventory = {'Sword': Item(5, 1, 15, 2),
             'Armor': Item(0, 10, 25, 5)}

for name, item in inventory.items():
    print "{0}: {1.attack} {1.defence} {1.weight} {1.price}".format(name, item)
