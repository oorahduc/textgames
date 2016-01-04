class Monster

  attr_accessor :name, :size, :desc
  def initialize
    @names = ["Snake", "Dragon", "Bear"]# ; @name = @names.sample
    @name = "Base Monster Name"

    @sizes = ["tiny", "small", "monstrous"] #; @size = @sizes.sample
    # @size = "Base Monster Size"
  end

  attr_reader :desc
  def desc
    @desc = "Before you is a #{@name} of #{@size} size."
  end

  attr_reader :size
  def size
    @size = "Base Monster Size"
  end

  attr_reader :stats
  def attr
    {
      :hp => 10,
      :atk => 1
    }
  end

end

class Dragon < Monster

  attr_accessor :name
  def initialize
  end

  def name=(name)
    @name = name
  end

  def desc=(desc)
    @desc = desc
  end

end

puts "Monster class:"
mob = Monster.new
puts mob.name
puts mob.size
puts mob.desc

puts "\nDragon class:"
dr = Dragon.new
dr.name = "Puff"

puts dr.name
puts dr.size
puts dr.desc
puts dr.stats[:hp]
puts dr.stats[:atk]


