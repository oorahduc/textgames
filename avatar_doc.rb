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
    @inventory
  end

  def additem(itemobject)
    if @location.objects.include?(itemobject) # ******** PSEUDO CODE

      # Temporarily save object to drop to the room.
      @tmp = itemobject

      # Pop item out of room
      @location.delete(itemobject) # ******** PSEUDO CODE

      # Add object to inventory array.
      @inventory << @tmp
    else
      puts "You can't find it."
    end
  end

  def dropitem(itemobject)
    if @inventory.include?(itemobject)

      # Temporarily save object to drop to the room.
      @tmp = itemobject

      # Pop item out of inventory
      @inventory.delete(itemobject)

      # Add item to room.
      @location.additem(itemobject) # ******** PSEUDO CODE
    else
      puts "You can't find it."
    end
  end

  def damage(damage)
    @hitpoints -= damage
    puts "Ouch! #{damage} damage taken!"
  end

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

  def dead?
    if @hitpoints <= 0
      puts "You DIED!!"
      exit
    else
      puts "Something happened. You're in purgatory."
      exit
    end
  end

end
