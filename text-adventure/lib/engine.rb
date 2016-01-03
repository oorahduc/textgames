require 'readline'

class Engine
  attr_accessor :splash_message
  attr_reader :avatar

  def avatar=(avatar); @avatar = avatar; end

  def initialize(controller)
    @ctrl = controller
  end

  def repl
  	puts @ctrl.current_message
  	input = prompt
  	@ctrl.evaluate(input)
  	repl
  end

  def prompt
    puts avatar.health, avatar.maxhealth
    Readline.readline('> ', true)
  end

  def start
    # Print splash message
    puts @splash_message
    # Start the game loop
    repl
  end

end
