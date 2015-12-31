#!/usr/bin/env ruby
# encoding: utf-8

require 'json'
require 'readline'

class Game
  def initialize
    puts "Welcome to the Game!"
  end

  def startGame
    loadArea("area_ex.json")
    @area_hash = JSON.parse(@area_file)
    puts @area_hash
  end

  def loadArea(area)
    begin
      @area_file = File.read(area)
      puts "Area [#{area}] loaded. "
    rescue
      puts "Unable to load area."
      exit
    end
  end

  def movePlayer(player, room_id)
    player.location = room_id
  end

  def prompt
    loop do
      @player_cmd = Readline.readline(">", true)
    end
  end
end

class Player
  attr_reader :name
  attr_accessor :hp, :location, :player_attr
  def initialize(name, location)
    @player_attr = {:current_hp => 100, :max_hp => 100}
    @name = name
    # @current_hp = 100
    # @max_hp = 100
    @location = location
  end

  def hurtPlayer(damage)
    @hp = @hp - damage
  end

  def healPlayer(healing)
    @hp = @hp + healing
  end

end

newgame = Game.new
newgame.startGame
chris = Player.new('Chris', '0001')
puts chris.name
puts chris.hp
chris.hp = 50
puts chris.hp
chris.name = "Lucas"
puts chris.name
chris.hurtPlayer(40)
puts chris.hp
