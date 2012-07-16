require 'grid-array'
require 'ant'
require 'clever-ant'
require 'dumb-ant'

maze = GridArray.new([
  [0,1,0,0,0,0,0,0,0],
  [0,1,0,0,1,0,1,0,0],
  [0,1,0,0,1,0,1,0,0],
  [0,1,1,1,1,0,1,1,0],
  [0,1,0,0,0,0,0,1,0],
  [0,1,1,1,1,1,0,1,0],
  [0,0,0,0,0,0,0,1,0],
])


AndrewAnt.generate(0,0)
AlanAnt.generate(0,0)
DumbAnt.generate(0,0)
LessDumbAnt.generate(0,0)
CleverAnt.generate(0,0)

i = 1
loop do 
  #sleep 0.2
  Ant.move_all(i)
  maze.present
  i = i + 1
  if Ant.all_finished?
    Ant.all.each{|ant| puts ant.inspect}
    return
  end
end
