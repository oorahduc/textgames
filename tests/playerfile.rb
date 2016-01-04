require 'yaml'

player_attr = YAML.load_file('playerfile.yml')

player_attr[0]["playername"] = "Chris"

puts player_attr.inspect

inventory = player_attr[0]["inventory"]
puts inventory
