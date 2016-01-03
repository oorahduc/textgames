class Monster


  attr_accessor :name, :size, :description
  def initialize
    @names = ["Snake", "Dragon", "Bear"]
    @name = @names.sample

    @sizes = ["tiny", "small", "monstrous"]
    @size = @sizes.sample
  end

  attr_reader :description
  def description
    puts "Before you is a #{@size} #{@name}"
  end

end

mob = Monster.new
puts mob.name


# puts mob.description
