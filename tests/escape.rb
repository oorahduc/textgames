#!/usr/bin/ruby
# The Escape v 1.0
#----------------methods are defined here------------------------------
 def start
puts "                      "
puts "                      "
puts                           " --- The Escape --- "
puts" ----------------"
puts"|1) New Game     |"
puts"|2) Load Game    |"
puts"|3) Intro        |"
puts"|4) About        |"
puts"|5) Exit         |"
puts" ---------------- "
$choice=0
 until (($choice>=1)&&($choice<=5)) do
puts "Chose your option:"
$choice = gets.chomp.to_i
end

if ($choice==4)
about
start
end

if ($choice==3)
intro
start
end

if ($choice==5)
close
end

if ($choice==2)
load_game
end

if ($choice==1)
new_game
end

 end
# end of start method
def new_game
puts "Please choose a character name:"
$name = gets.chomp
$file_name = $name + ".ca"
while(system("test -e '#{$file_name}'")) do
puts "That name is taken, please choose another one."
$name = gets.chomp
$file_name = $name + ".ca"
end
system("touch '#{$file_name}'")
$lvl = 1
$gold = 0
$inventory = []
save
end
#end of  new_game
def save
f = File.new("#{$file_name}","w")
f.puts "#{$name}"
f.puts "#{$lvl}"
f.puts "#{$gold}"
f.puts  "#{$inventory}"
f.close
end
# end of save method
def load_game
puts "Please choose one of the below saved profiles:"
system ("ls *.ca")
print ":"
$name = gets.chomp
$file_name = $name + ".ca"
while(!system("test -e '#{$file_name}'")) do
puts "Such profile does not exits, please choose a valid one."
system ("ls *.ca")
print ":"
$name = gets.chomp
$file_name = $name + ".ca"
end
info = IO.readlines("#{$file_name}") # info is a array and each index value is the info of a line info[3] = info that is on line number three.
# now info is acctualy being loaded intro the system variables
$name = info[0]
$lvl  = info[1]
$gold = info[2]
for i in 3..((info.length)-1) do
$inventory[$inventory.length] = info[i] # with $inventory.length start from 0 becuse it's initial null it will automaticaly grow
end
puts "Loading please wait..."
sleep(2)
print "............"
sleep(1)
puts "............"
puts $name
puts $gold
puts $lvl
puts $inventory
####call the level method
end
# end of load game
def intro
puts"You are sent to prison for a crime you are not responsable, but soon a path is showing up..."
sleep (5)
end
# end of intro
def about
puts"This is a text based game written in Ruby. The game was created by Stoian Dan in 2014 and is released under GPL3 License or later."
sleep (5)
end
# end of about
def close
exit
end
# end of close method

#--------------- methods ending----------------------
$inventory = [] # def te inventory

# -------------- GAME IS STARTING-------------------
start
