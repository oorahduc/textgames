class Item
  attr_accessor :name, :type, :attack, :armor, :wearloc, :weight, :price, :exam
  def initialize(object)
    @name = object['name']
    @type = object['type']
    @attack = object['attack']
    @armor = object['armor']
    @wearloc = object['wearloc']
    @weight = object['weight']
    @price = object['price']
    @take = object['take']
  end

  def exam
    self.map do |k,v|
      puts "#{k} : #{v}"
    end
  end
end
