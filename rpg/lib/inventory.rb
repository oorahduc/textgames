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
    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def to_s
        @items.each do |item|
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
inv.add_item(broadsword)
inv.add_item(breastplate)
inv.to_s
