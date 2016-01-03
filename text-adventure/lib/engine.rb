require 'readline'

class Engine
  attr_accessor :splash_message

  def initialize(controller)
    @ctrl = controller
  end

  def repl
  	puts @ctrl.current_message
  	puts @ctrl.avatar.location.listexits
  	input = prompt
  	@ctrl.evaluate(input)
  	repl
  end

  def prompt
    Readline.readline('> ', true)
  end

  def start
    # Print splash message
    puts @splash_message
    # Start the game loop
    repl
  end

end
