module Equipment
  class Equipment

    attr_accessor :worn, :possible_wearlocs
    def initialize
      @worn = Hash.new
      @possible_wearlocs = ["head", "neck", "shoulders", "torso", "arms", "hands", "finger", "legs", "feet", "wielding"]

      @vowels = "aeiou"
      @articles = ['a', 'an']
    end

    # Equipped class
    attr_accessor :equipped
    def equipped
      puts "Equipment:".blue
      if @worn.empty?
        puts "You are wearing nothing."
      else
        listeq
      end
    end

    # Avatar Method to wear item by matched keyword
    attr_accessor :wear_item
    def wear_item(keyword)
      begin
        @inventory.contents.map{|x| @equipment.worn[x.wearloc] = x and @inventory.contents.delete(x) and puts "You equipped #{x.name}." if x.name.include?(keyword)}
      rescue
        puts "You don't have that."
      end
    end

    # Avatar Method to remove item by matched keyword
    attr_accessor :remove_item
    def remove_item(keyword)
      begin
        @equipment.worn.map.each { |x| o = x[1] and @inventory.contents << o and @equipment.worn.delete(o.wearloc) and puts "You remove #{x[1].name}" if x[1].name.include?(keyword) }
      rescue
        puts "You aren't wearing that."
      end
    end

    # Avatar Method to drop item by matched keyword
    attr_accessor :dropitem
    def dropitem(keyword)
      begin
        @inventory.contents.map{|x| location.objects << x and @inventory.contents.delete(x) and puts "You drop #{x.name}." if x.name.include?(keyword)}
      rescue
        puts "You don't have that."
      end
    end

    # Avatar Method to get item by matched keyword
    attr_accessor :getitem
    def getitem(keyword)
      begin
        location.objects.map{|x| @inventory.contents << x and location.objects.delete(x) and puts "You pick up #{x.name}." if x.name.include?(keyword)}
      rescue
        puts "You don't see that."
      end
    end

    # PRIVATE METHODS

    # List worn equipment
    private
    def listeq
      @worn.each do |key, val|
        if @vowels.include?(val.name[0])
          @article = @articles[1]
        else
          @article = @articles[0]
        end
        if val.wearloc == "wielding"
          puts "You are wielding #{@article} #{val.name.red}."
        else
          puts "You are wearing #{@article} #{val.name.cyan} on your #{val.wearloc}."
        end
      end
    end
  end
end
