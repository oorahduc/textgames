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
		when "get"
			keyword = tokens.last
			avatar.getitem(keyword)
		when "remove"
			keyword = tokens.last
			avatar.remove_item(keyword)
		when "heal"
			amount = tokens.last.to_i
			avatar.heal(amount)
		when "damage"
			amount = tokens.last.to_i
			avatar.damage(amount)
		when "stats"
			avatar.stats
		when "look", "l"
			eval_look(tokens)
		when "exam"
			eval_exam(tokens)
		when "test"
			avatar.inventory.inventory
		when "inventory", "inv", "i"
			avatar.showinventory
		when "testitems"
			avatar.createtestitems
		when "putsroom"
			puts avatar.location.inspect
		when "roomobjs"
			puts avatar.location.objects.inspect
		when "help"
			@current_message = @messages["help"]
		when "cmds"
			puts @commands.join(', ')
		when "exit", "quit"
			puts "Thank you for playing!"
			exit(0)
		end
	end

	private
	# Facilitator to Avatar#look_at_npc
	def eval_look(tokens)
		if tokens[1] == "at"
			avatar.look_at_npc(tokens[2])
		elsif tokens.size == 2
			puts "Look at what? Who?"
		else
			@current_message = avatar.location.display_room
		end
	end

	def eval_exam(tokens)
		avatar.inventory.contents.each.map do |i|
			if i.name.include?(tokens[1])
				## REFACTOR THIS
				# i.map { |k,v| puts "#{k} : #{v}" }
				# i.each { |k,v| puts "#{k} : #{v}" }
				puts i.to_yaml
			end
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
		elsif tokens.size > 2
			result = true
		end
		result
	end

	# Validate command tokens
	def valid_commands
		@commands ||= %w(look l exit quit cmds roomobjs putsroom test stats heal inventory inv i equipment equip eq wear remove rem drop get damage testitems putsroom help)
	end

end
