require 'shared'

maze = GridArray.new([
  [0,1,0,0,0,0,0,0,0],
  [0,1,0,0,1,0,1,0,0],
  [0,1,0,0,1,0,1,0,0],
  [0,1,1,1,1,0,1,1,0],
  [0,1,0,0,0,0,0,1,0],
  [0,1,1,1,1,1,0,1,0],
  [0,0,0,0,0,0,0,1,0],
])


generate_ants(0,0,5)


run_test(maze,0,60)
