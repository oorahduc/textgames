class Room
  attr_accessor :description, :rooms, :info, :handle
  attr_writer :starting_location
  attr_reader :avatar

  attr_accessor :objects, :npcs
  def initialize
    @objects = []
    @npcs = []

    @name_articles = ['A', 'An']
    @vowels = "aeiou"
  end

  def has_room_to_the?(direction)
    rooms.key?(direction)
  end

  def display_room
    puts description.blue, info.gray
    puts exits.brown
    listnpcs
    listobjects
  end

  # attr_accessor :listnpcs
  def listnpcs
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

  # attr_accessor :listobjects
  def listobjects
    if @objects
      @objects.each do |obj|
        if @vowels.include?(obj.name[0])
          @article = @name_articles[1]
        else
          @article = @name_articles[0]
        end
        puts "#{@article} #{obj.name} lies on the ground here."
      end
    end
    nil
  end

  def exits
    print "Exits: "
    rooms.keys.join(" ")
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
