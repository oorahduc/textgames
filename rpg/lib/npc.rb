require File.join(File.expand_path(File.dirname(__FILE__)), 'combat')
require File.join(File.expand_path(File.dirname(__FILE__)), 'util')

class Npc
  include Combat
  attr_accessor :name, :desc, :attack, :defense
  def initialize(object)
    @name = object['name']
    @desc = object['desc']
    @attack = object['attack']
    @defense = object['defense']
    @hitpoints = object['hitpoints']
  end
end
