require "readline"
while buf = Readline.readline("> ", true)
  p Readline::HISTORY.to_a
  if buf == "look"
    puts "The room is plain"
  end
  print("-> ", buf, "\n")
end
