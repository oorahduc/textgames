GAME_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require File.join(GAME_ROOT, 'lib', 'bootstrap')
require File.join(GAME_ROOT, 'lib', 'game')
require File.join(GAME_ROOT, 'lib', 'util')

def loaddata(path)
  File.absolute_path(File.join(GAME_ROOT, path))
end

# TODO: this could be a little nicer.
location_data_file = loaddata "#{ARGV[0]}"
item_data_file = loaddata "#{ARGV[1]}"
message_data_file = loaddata "#{ARGV[2]}"

# main
bootstrap = Bootstrap.new(location_data_file, item_data_file, message_data_file)
game = Game.new(bootstrap)
game.play
