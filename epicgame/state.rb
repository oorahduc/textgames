#!/usr/bin/env ruby
# encoding: utf-8

require 'json'
require 'readline'

class Game
  def initialize()
    puts "Welcome to the Game!"
  end

  def startGame
    loadZone("./lib/zones/starting_zone.json")
    # @player = class_a_instance

    @tmp_name = gets.chomp
    player = Player.new(@tmp_name)
    prompt
  end

  def loadZone(zone)
    begin
      @zone_file = File.read(zone)
      @zone = JSON.parse(@zone_file)
      puts "Zone '#{@zone[0]['zone_name']}' loaded. "
    rescue
      puts "Unable to load zone."
      exit
    end
  end

  def prompt
    while buf = Readline.readline("> ", true)
      # p Readline::HISTORY.to_a
      # print("-> ", buf, "\n")
      action(buf)
    end
  end

  def action(action)
    case action
    when "look"
      look
    when "stats"
      Player.stats
    else
      puts "Huh?"
    end
  end

  def look
    puts @zone[0]["rooms"]["#{Player.location}"]["title"]
    puts @zone[0]["rooms"]["#{Player.location}"]["description"]
  end

end

class Player
  attr_reader :name
  attr_accessor :hp, :location, :player_attributes
  def initialize(name)
    @player_attributes = {:current_hp => 100, :max_hp => 100}
    @player_name = name
    @player_location = 0001
  end

  attr_reader :stats
  def show_stats
    # puts "You have #{@player_attributes[:current_hp]} of #{@player_attributes[:max_hp]}"
    # puts "#{@player_attributes}"
    @stats = @player_attributes
    # puts "You are currently in #{@zone[0]['rooms']['#{@player_location}']['title']}"
  end

  def hurtPlayer(damage)
    @hp = @hp - damage
  end

  def healPlayer(healing)
    @hp = @hp + healing
  end

end


gamestate = Game.new
gamestate.startGame
puts player.stats



# chris = Player.new('Chris', '0001')
# puts chris.name
# puts chris.hp
# chris.hp = 50
# puts chris.hp
# chris.name = "Lucas"
# puts chris.name
# chris.hurtPlayer(40)
# puts chris.hp
