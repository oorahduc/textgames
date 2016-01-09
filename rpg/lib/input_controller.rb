class InputController
	attr_reader :avatar, :current_message, :room, :item

	def avatar=(avatar)
		@avatar = avatar
	end

	def messages=(messages)
		@messages = messages
	end

	def initialize_message
		# @current_message = avatar.location.display_room
		# puts "this is the init message".red  # INIT MESSAGE
	end

	def evaluate(input)
		tokens = input.split
		unless valid?(input)
			@current_message = "Sorry, that is not a valid command."
			return
		end

		# Evaluate commands
		command = tokens.first
		case command
		when "go"
			direction = tokens.last
			if avatar.can_move?(direction)
				avatar.move(direction)
				@current_message = avatar.location.display_room
			else
				@current_message = "Sorry, you cannot go #{direction} from here."
			end
		when "wear"
			keyword = tokens.last
			player.wear(keyword)
		when "heal"
			amount = tokens.last.to_i
			avatar.heal(amount)
		when "damage"
			amount = tokens.last.to_i
			avatar.damage(amount)
		when "stats"
			avatar.stats
		when "look"
			@current_message = avatar.location.display_room
		when "test"
			# @current_message = avatar.location.info
			# @current_message = avatar.location.roomexits
			# @current_message = avatar.maxhealth
			# @current_message = avatar.showstats
			# avatar.damage(50)
			# avatar.showstats
			# avatar.heal(30)
			# avatar.showstats
			puts items.inspect
		when "help"
			@current_message = @messages["help"]
		when "exit", "quit"
			puts "Thank you for playing!"
			exit(0)
		end

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
