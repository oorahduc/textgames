class Avatar

  # MAX_HP = 300

  def location
    @current_room
  end

  attr_accessor :player_name
  def initialize(starting_location)
    @current_room = starting_location
    @player_name = "Chris"
    @hitpoints = 300
    @maxhitpoints = 300
    @inventory = []
  end

  def can_move?(direction)
    @current_room.has_room_to_the?(direction)
  end

  def move(direction)
    if can_move?(direction)
      new_room = @current_room.rooms[direction]
      @current_room = new_room
      true
    else
      false
    end
  end

  def hitpoints
    @hitpoints
  end

  def inventory
    @inventory = []
  end

  # def showstats
  #   @healthpct = @stats[:current_hp].to_f.percent_of(@stats[:max_hp].to_f).round
  #   puts "#{@stats[:current_hp]} / #{@stats[:max_hp]} (#{@healthpct}%) health. RATCHAFATCHA!"
  # end

  def damage(damage)
    @stats[:current_hp] = @stats[:current_hp] - damage
    puts "Ouch! #{damage} damage taken!"
  end

  def heal(healing)
    if healing >= @stats[:max_hp] - @stats[:current_hp]
      healing = @stats[:max_hp] - @stats[:current_hp]
      @stats[:current_hp] = @stats[:current_hp] + healing
      puts "Yay! +#{healing} to health!"
    else
      @stats[:current_hp] = @stats[:current_hp] + healing
      puts "Yay! +#{healing} to health!"
    end
  end

  def dead?
    if @stats[:current_hp] <= 0
      puts "You DIED!!"
      exit
    else
      puts "Something happened. You're in purgatory."
      exit
    end
  end

end
