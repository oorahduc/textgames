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

	# Begin command evaluation
	def evaluate(input)
		tokens = input.split
		unless valid?(input)
			# @current_message = "Sorry, that is not a valid command."
			puts "Sorry, that is not a valid command."
			return
		end

		# Evaluate commands & parameters
		command = tokens.first
		case command
		when "go"
			direction = tokens.last
			if avatar.can_move?(direction)
				avatar.move(direction)
				@current_message = avatar.location.display_room
			else
				puts "Sorry, you cannot go #{direction} from here."
			end
		when "equipment", "equip", "eq"
			avatar.equipped
		when "wear"
			keyword = tokens.last
			avatar.wear_item(keyword)
		when "remove", "rem"
			keyword = tokens.last
			avatar.remove_item(keyword)
		when "drop"
			keyword = tokens.last
			avatar.dropitem(keyword)
		when "heal"
			amount = tokens.last.to_i
			avatar.heal(amount)
		when "damage"
			amount = tokens.last.to_i
			avatar.damage(amount)
		when "stats"
			avatar.stats
		when "look", "l"
			@current_message = avatar.location.display_room
		when "test"
			puts items.inspect
		when "inventory", "inv", "i"
			avatar.showinventory
		when "testitems"
			avatar.createtestitems
		when "putsroom"
			puts avatar.location
		when "roomobjs"
			puts avatar.location.objects
		when "help"
			@current_message = @messages["help"]
		when "cmds"
			puts @commands.join(', ')
		when "exit", "quit"
			puts "Thank you for playing!"
			exit(0)
		end

	end

	# Validate command token.first
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

	# Validate command tokens
	def valid_commands
		@commands ||= %w(look l exit quit cmds test stats heal inventory inv i equipment equip eq wear remove rem drop get damage testitems putsroom help) # add:  get, drop, wear, wield, remove
	end

end
