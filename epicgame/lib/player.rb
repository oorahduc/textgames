class Player
  attr_reader :name
  attr_accessor :hp, :location, :attributes
  def initialize(name, location)
    @attributes = {:current_hp => 100, :max_hp => 100, :location => location}
    @name = name
    # @current_hp = 100
    # @max_hp = 100
    @location = ""
  end

  def move(room)
    @location = room
  end

  def hurtPlayer(damage)
    @attributes[:current_hp] -= damage
  end

  def healPlayer(healing)
    @attributes[:current_hp] += healing
  end

end
