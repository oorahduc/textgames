class Player
  def initialize
    @inventory = Inventory.new
    @worn = []
    @input = "brick"
    puts "inv:" ; puts @inventory.contents.inspect
    puts "\nworn:" ; puts @worn.inspect
    # @inventory.contents.map{|x| wear(x) if x.name.include?(@input) }
    puts "wear:"
    wear(@input)
    puts
    puts "\ninv:" ; puts @inventory.contents.inspect
    puts "\nworn:" ; puts @worn.inspect
    @inventory.list_contents
  end
  def wear(keyword)
    @inventory.contents.map{|x| @worn << x and @inventory.contents.delete(x) if x.name.include?(keyword) }
  end
end

class Inventory
  attr_accessor :contents, :list_contents
  def initialize
    @contents = []
    @stick = Item.new('a brown stick', 'long and pointy')
    @brick = Item.new('a red brick', 'rough and heavy')
    @contents << @stick
    @contents << @brick
  end
  def list_contents
    @contents.each {|item| puts item.name }
    nil
  end
end


class Item
  attr_accessor :name, :desc
  def initialize(name, desc)
    @name = name
    @desc = desc
  end
end

player = Player.new
# puts inv.contents.inspect
# puts inv.list_contents
# puts inv.contents.inspect


# inv.contents.map do |x|
#   puts x.name if x.name == input.split(' ').first
# end


