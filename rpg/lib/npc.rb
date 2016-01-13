class Npc
  attr_accessor :name, :type, :attack, :armor, :wearloc, :weight, :price
  def initialize(object)
    @name = object['name']
    @desc = object['desc']
    @attack = object['attack']
    @defense = object['defense']
  end
end
