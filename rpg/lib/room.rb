class Room
  attr_accessor :description, :rooms, :info, :handle, :action
  attr_writer :starting_location
  attr_reader :avatar

  attr_accessor :objects, :npcs
  def initialize
    @objects = []
    @npcs = []
    @action = []

    @name_articles = ['A', 'An']
    @vowels = "aeiou"
  end

  def has_room_to_the?(direction)
    rooms.key?(direction)
  end

  def display_room
    puts description.blue, info.gray.para
    puts exits
    list_npcs
    list_objects
  end

  attr_accessor :eval_action
  def eval_action
    if @action['show'] == true
      do_action(@action)
    end
  end

  def do_action(action)
    case action['type']
    when "periodic_message"
      msg = Thread.new {
        count = 0
        while count < @action['num'] do
          sleep(rand(10..20))
          puts @action['message']
          puts
          count += 1
        end
        msg.kill
      }
    when "onetime_message"
      puts
      puts @action['message']
      puts
    end
  end

  def list_npcs
    unless !@npcs
      @npcs.each do |npc|
        if @vowels.include?(npc.name[0])
          @article = @name_articles[1]
        else
          @article = @name_articles[0]
        end
        puts " #{@article} #{npc.name} stands here.".magenta
      end
    end
    nil
  end

  def list_objects
    if @objects
      @objects.each do |obj|
        if @vowels.include?(obj.name[0])
          @article = @name_articles[1]
        else
          @article = @name_articles[0]
        end
        puts " #{@article} #{obj.name} lies on the ground here."
      end
    end
    nil
  end

  def exits
    @ex = rooms.keys.join(" ")
    print "[ #{@ex.brown} ]"
  end

  # attr_accessor :additem
  def additem(item)
    @objects << item
    # puts @objects.class
    nil
  end

  # attr_accessor :delitem
  def delitem(item)
    @objects.delete(item)
  end

  def starting_location?
    @starting_location
  end
end
