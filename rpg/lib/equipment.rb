class Equipment
  attr_accessor :worn, :equipped, :possible_wearlocs
  def initialize
    @worn = Hash.new
    @possible_wearlocs = ["head", "torso", "finger", "wielding"]
  end

  def equipped
    puts "Equipment:".blue
    if @worn.empty?
      puts "You are wearing nothing."
    end
    @worn.each do |key, val|
      if val.wearloc == "wielding"
        puts "You are wielding #{val.name.red}."
      else
        puts "You are wearing #{val.name.cyan} on your #{val.wearloc}."
      end
    end
  end

end
