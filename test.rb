#!/usr/bin/env ruby
# encoding: utf-8

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


chris = Player.new('Chris', '0001')
puts chris.name
# puts chris.hp
chris.hp = 50
puts chris.hp
# chris.name = "Lucas"
puts chris.name
chris.hurtPlayer(40)
puts chris.hp
puts "current hp: #{chris.player_attr[:current_hp]}"
puts "max hp: #{chris.player_attr[:max_hp]}"
puts "location: #{chris.location}"
