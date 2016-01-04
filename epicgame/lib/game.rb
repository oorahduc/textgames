class Game
  def initialize
    puts "Welcome to the Game!"
  end

  def startGame
    loadZone("./lib/zones/starting_zone.json")
    puts @zone_hash
    prompt
  end

  def loadZone(zone)
    begin
      @zone_file = File.read(zone)
      @zone_hash = JSON.parse(@zone_file)
      puts "Zone #{@zone_hash[0]['zone_name']} loaded. "
    rescue
      puts "Unable to load zone."
      exit
    end
  end

  def movePlayer(player, room_id)
    player.location = room_id
  end

  def prompt
    while buf = Readline.readline("> ", true)
      p Readline::HISTORY.to_a
      if buf == "look"
        puts "The room is plain"
      end
      print("-> ", buf, "\n")
    end
  end
end
