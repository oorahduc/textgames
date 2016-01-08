class Person
  attr_accessor :first, :last, :weight, :height

  def initialize(params = {})
    @first = params[:first]
    @last = params[:last]
    @weight = params[:weight]
    @height = params[:height]
  end
end

p = Person.new(
  height: 170,
  weight: 72,
  last: 'Doe',
  first: 'John'
)

puts p
