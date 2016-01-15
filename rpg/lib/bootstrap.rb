lib_dir = File.expand_path(File.dirname(__FILE__))

require File.join(lib_dir, 'avatar')
require File.join(lib_dir, 'input_controller')
require File.join(lib_dir, 'game_data_loader')
require File.join(lib_dir, 'util')

class Bootstrap
  def initialize(location_data_file, message_data_file)
    @locations = loader.load_location_data(location_data_file)
    @messages = loader.load_message_data(message_data_file)
  end

  def starting_location
    @locations.find {|location| location.starting_location?}
  end

  def avatar
    # @av_name = gets.chomp
    Avatar.new("Hero", starting_location)
  end

  def loader
    @loader ||= GameDataLoader.new
  end

  def controller
    ctrl = InputController.new
    ctrl.messages = @messages
    ctrl.avatar = avatar
    ctrl.initialize_message
    ctrl
  end

  def splash_message
    @bitops_link = "https://github.com/bitops/text-adventure"
    @intro = "Welcome to an Epic Adventure of modest proportions but with the potential to be enormous. This world was spawned out of Sebastian Wittenkamp's Text Adventure (#{@bitops_link}). Please begin by looking at your suroundings. You will find curiosities... and you will find danger...".cyan.para
    puts @intro
    @messages["splash"]
  end

end
