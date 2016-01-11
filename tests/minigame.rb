class World
  attr_accessor :armor_list, :weapon_list, :monsters, :scenes
  def initialize()
    @weapon_list = {
            short:      {name: "Short sword", power: 5 },
        long:       {name: "Long sword", power: 8 },
        two_handed: {name: "Two-Handed sword", power: 12 },
        warhammer:  {name: "Warhammer sword", power: 10 }
          }

    @armor_list = {
            leather:    {name: "Leather Armor", power: 5 },
        chain:      {name: "Chain Mail", power: 10 },
        plate:      {name: "Plate Mail", power: 15 },
        elven:      {name: "Elven Chain Mail", power: 50 }
      }

    @monsters = {
        rat:        {name: "Rat", level: 1 },
        thief:      {name: "Thief", level: 50 },
        dragon:     {name: "Dragon", level: 12 }
     }

    @scenes = [
    { name: "City", history: "The city.", weapons: [@weapon_list[:long]], armors: [@armor_list[:chain]], monsters: [@monsters[:thief], @monsters[:rat]] },
    { name: "Mountain", history:  "The mountain.", weapons: [@weapon_list[:warhammer]], armors: [@armor_list[:chain]], monsters: [@monsters[:dragon]] }
      ]
  end
end

class Game
  def initialize
    @player = Creature.new name: "You", level: 5
    @world = World.new
  end

  def play
    @current_scene = Scene.new(@world.scenes.first)
    @current_scene.intro

    while @player.is_alive?
        self.show_choices
    end
  end

  def show_choices
    puts <<-CHOICES
    What would you like to do here?
    1. Look for armor
    2. Look for weapons
    3. Look for monsters to fight
    4. Go to another place!
    CHOICES
    choice = gets.chomp

    case choice
    when "1"
        self.look_for_armor
    when "2"
        self.look_for_weapons
    when "3"
        self.look_for_monsters
    when "4"
          puts "bad choice, since I am not ready yet!"
    else
          puts "Can't you read?"
          exit
    end
  end

  def look_for_monsters
      monster = @current_scene.monsters.first
      battle [@player, monster]
  end

  def look_for_armor
      armor = select_equipment @current_scene.armors
      return if armor.nil?
      @player.wear_armor(@current_scene.armor_picked(armor))
  end

  def look_for_weapons
      weapon = select_equipment @current_scene.weapons
      return if weapon.nil?
      @player.wear_weapon(@current_scene.weapon_picked(weapon))
  end

  def select_equipment(equipment)
    @player.introduce_self

    puts "You wanna some equipment?"
    equipment.each_with_index do |item, i|
      puts "#{i+1}. #{item.name}"
    end

    gets.chomp.to_i - 1
  end

  def battle(opponents)
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
end

class Scene
  attr_reader :monsters, :armors, :weapons

  def initialize(setup)
    @name = setup[:name]
    @history = setup[:history]
    @armors = setup[:armors].map { |x| Armor.new x }
    @weapons = setup[:weapons].map { |x| Weapon.new x }
    @monsters = setup[:monsters].map { |x| Creature.new x }
  end

  def intro()
    puts "You are in the " + @name + "."
    puts @history
    equipment_list
  end

  def armor_picked(index)
    @armors.delete_at(index)
  end

  def weapon_picked(index)
    @weapons.delete_at(index)
  end

  def equipment_list()
        (@armors + @weapons).each {|a| puts "You see some #{a.name} lying on the ground." }
  end
end

class Creature
  attr_reader :name, :life, :weapon, :armor
  def initialize(config)
    @name = config[:name]
    @level = config[:level]
    @equipment = {:armor => nil, :weapon => nil}
    @armor = 0
    @weapon = 0
    #3.times rand(7) or 3*rand(7) doesn't create the effect, I tried rand(16)+3 but didn't like it.
    @strength = rand(7) + rand(7) + rand(7)
    @condition = rand(7) + rand(7) + rand(7)
    @life = @level * (rand(8) + 1)
    @power = @strength * (rand(4) + 1)
    @regen = @condition
  end

  def introduce_self()
      puts "You wear "  + (@equipment[:armor]  || "no armor!")
      puts "You carry " + (@equipment[:weapon] || "no no weapon!")
  end

  def wear_armor(armor)
    @armor = armor.power
    @equipment[:armor] = armor.name
  end

  def wear_weapon(weapon)
    @weapon = weapon.power
    @equipment[:weapon] = weapon.name
  end

  def attack(defender)
    [@power + @weapon - defender.armor, 0].max
  end

  def defend(attack)
    @life -= attack
  end

  def regen
    @life += @regen
    @regen
  end

  def is_alive?
    @life > 0
  end
end

class Weapon
  attr_reader :name, :power
  def initialize(setup)
    @name = setup[:name]
    @power = setup[:power]  end
end

class Armor
  attr_reader :name, :power
  def initialize(setup)
    @name = setup[:name]
    @power = setup[:power]
  end
end

game = Game.new()
game.play()
