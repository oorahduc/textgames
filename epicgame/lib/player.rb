class Player
  attr_reader :name
  attr_accessor :hp, :location, :attributes
  def initialize(name, location)
    @attributes = {:current_hp => 100, :max_hp => 100, :location => location}
    @name = name
    # @current_hp = 100
    # @max_hp = 100
    # @location = location
  end

  def hurtPlayer(damage)
    @hp = @hp - damage
  end

  def healPlayer(healing)
    @hp = @hp + healing
  end

end
