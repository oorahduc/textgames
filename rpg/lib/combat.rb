module Combat
  # BASE_STATS = {
  #   max_hit_points: 10,
  #   attack_power:   1
  # }

  def Combat.included(mod)
    attr_accessor :hit_points, :attack_power
  end

  def initialize_stats(stats)
    # @stats = stats

    # @hit_points   = stats[:max_hit_points]
    # @attack_power = stats[:attack_power]
  end

  def monster_alive?
    @monster_hitpoints > 0
  end

  # Check to see if avatar is dead.
  # May need to be moved to Combat module in the future.
  def alive?
    if @hitpoints <= 0
      puts "You DIED!!"
      exit
      # elsif @hitpoints > 0 then
      #   next
    end
  end

  # Avatar class call to damage avatar's hitpoints
  def damage(damage)
    @hitpoints -= damage
    puts "Ouch! #{damage} damage taken!"
    # alive?
  end

  # avatar class call to heal avatar's hitpoints
  def heal(healing)
    if healing >= @maxhitpoints - @hitpoints
      healing = @maxhitpoints - @hitpoints
      @hitpoints += healing
      puts "Yay! +#{healing} to health!"
    else
      @hitpoints += healing
      puts "Yay! +#{healing} to health!"
    end
  end
end
