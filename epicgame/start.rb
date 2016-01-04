#!/usr/bin/env ruby
# encoding: utf-8

require 'json'
require 'readline'
require './lib/game'
require './lib/avatar'


instance = Game.new
instance.startgame
chris = Player.new('Chris', '0001')


# puts chris.name
# puts chris.hp
# chris.hp = 50
# puts chris.hp
# chris.name = "Lucas"
# puts chris.name
# chris.hurtPlayer(40)
# puts chris.hp

# puts chris.name
# chris.hurtPlayer(40)
# puts chris.hp
# puts "current hp: #{chris.attributes[:current_hp]}"
# puts "max hp: #{chris.attributes[:max_hp]}"
# puts "location: #{chris.location}"
