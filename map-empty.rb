require 'shared'

maze = GridArray.generate_empty(5,5)

generate_ants(2,2,2)
#SequenceAnt.generate(4,0)

run_test(maze,0.1)
