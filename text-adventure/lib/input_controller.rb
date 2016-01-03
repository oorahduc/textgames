class InputController
	attr_reader :avatar, :current_message, :room

	def avatar=(avatar)
		@avatar = avatar
	end

	def messages=(messages)
		@messages = messages
	end

	def initialize_message
		@current_message = avatar.location.display_room
		puts "this is the init message".red  # INIT MESSAGE
	end

	def evaluate(input)
		tokens = input.split
		unless valid?(input)
			@current_message = "Sorry, that is not a valid command."
			return
		end

		command = tokens.first

		if command == "go"
			direction = tokens.last
			if avatar.can_move?(direction)
				avatar.move(direction)
				@current_message = avatar.location.display_room
			else
				@current_message = "Sorry, you cannot go #{direction} from here."
			end
		end

		if command == "heal"
			amount = tokens.last.to_i
			avatar.heal(amount)
		end

		if command == "damage"
			amount = tokens.last.to_i
			avatar.damage(amount)
		end

		if command == "look"
			@current_message = avatar.location.display_room
		end

		if command == "test"
			# @current_message = avatar.location.info
			# @current_message = avatar.location.roomexits
			@current_message = avatar.maxhealth
			# @current_message = avatar.showstats
			avatar.damage(50)
			avatar.showstats
			avatar.heal(30)
			avatar.showstats
		end

		if command = "stats"
			avatar.showstats
		end

		if command == "help"
			@current_message = @messages["help"]
		end

		if command == "exit" || command == "quit"
			puts "Thank you for playing!"
			exit(0)
		end
	end

	def output(message)
		puts message
	end

	def valid?(input)
		tokens = input.split
		result = false
		if valid_commands.include?(tokens.first) && tokens.size == 1
			result = true
		elsif tokens.size == 2
			result = true
		end
		result
	end

	def valid_commands
		@commands ||= %w(look exit quit test stats heal damage help)
	end

end
