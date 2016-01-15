module Combat
  # BASE_STATS = {
  #   max_hit_points: 10,
  #   attack_power:   1
  # }

  def Combat.included(mod)
    attr_accessor :hit_points, :attack_power
  end

  def initialize_stats(stats)
  end

  # MUST BE REFACTORED
  def init_combat(opponents)
    attack_turn = 0
    while opponents.all?(&:is_alive?)
    attacker = opponents[attack_turn]
    defender = opponents[(attack_turn + 1) % 2]

    attack = attacker.attack(defender)
    defender.defend(attack)
    puts "#{attacker.name} hit #{defender.name} with #{attack} points of damage!"
    puts "#{defender.name} regenerates #{defender.regen} points of life!" if defender.is_alive?

    puts "Hit points:"
    opponents.each { |o| puts "#{o.name}: #{o.life}" }

    attack_turn = (attack_turn + 1) % 2
    end

    winner = opponents.first(&:is_alive?)
    puts winner.name
  end

  # Check if monster alive?
  def monster_alive?
    @monster_hitpoints > 0
  end

  # Check if avatar alive?
  def is_alive?
    if @hitpoints <= 0
      puts "You DIED!!"
      exit
    end
  end

  # PSEUDO CODE. NOT YET IMPLEMENTED.
  def attack(defender)
    [@attr[:str] + @weapon.attack - defender.armor, 0].max
  end

  # PSEUDO CODE. NOT YET IMPLEMENTED.
  def defend(attack)
    @hitpoints -= attack
  end

  # Cause damage
  def damage(damage)
    @hitpoints -= damage
    puts "Ouch! #{damage} damage taken!"
    # alive?
  end

  # Heal health
  def heal(healing)
    @healmsg = "Yay! +#{healing} to health!"
    if healing >= @maxhitpoints - @hitpoints
      healing = @maxhitpoints - @hitpoints
      @hitpoints += healing
      puts @healmsg
    else
      @hitpoints += healing
      puts @healmsg
    end
  end
end
