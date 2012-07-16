class DumbAnt < Ant

  # both expect a single array, column, and row e.g. [0,0]

  def move(iteration=0)
    return if stop_if_finished(iteration)
    options = GridArray.current.options_from(position[0],position[1])
    next_pos = options[rand(options.length)]
    set_position next_pos[0], next_pos[1]
  end  

  def set_attributes
    self.character = 'D'
  end

end

class LessDumbAnt < Ant

  # both expect a single array, column, and row e.g. [0,0]
  attr_accessor :last_position

  def move(iteration=0)
    return if stop_if_finished(iteration)
    options = GridArray.current.options_from(position[0],position[1])
    options.delete self.last_position unless options.length == 1
    next_pos = options[rand(options.length)]

    self.last_position = self.position

    set_position next_pos[0], next_pos[1]
  end  

  def set_attributes
    self.character = 'L'
  end

end