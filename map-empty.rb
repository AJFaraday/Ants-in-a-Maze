require 'shared'

maze = GridArray.generate_empty(5,5)

generate_ants(0,0,10)

run_test(maze,0.1)
