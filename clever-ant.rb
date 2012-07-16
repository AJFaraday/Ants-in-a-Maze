class CleverAnt < Ant

  # both expect a single array, column, and row e.g. [0,0]
  attr_accessor :last_position
  attr_accessor :decisions
  # A list of previously black-listed locaitons
  attr_accessor :blacklist
  # boolean flag for backtracking behaviour
  attr_accessor :backtracking
  attr_accessor :path
 
  def move(iteration=0)

    return if self.stop_if_finished(iteration)

    options = GridArray.current.options_from(position[0],position[1])

    options.delete(self.last_position)
    blacklist.each{|blacklisted_slot| options.delete(blacklisted_slot)}
    
    if options.length == 0
      self.backtracking = true
    elsif options.length > 1
      self.decisions << self.position
    end
    self.blacklist << self.position 
    self.blacklist.uniq!

    self.last_position = self.position
    if self.backtracking == true
      backtracking_move
    else
      self.mark_current_position_visited
      next_pos = options[rand(options.length)]
      set_position next_pos[0], next_pos[1]
    end    
  end

  def backtracking_move
    self.set_position(self.path[-1][0], self.path[-1][1])
    self.path.delete_at(-1)
    if self.position == self.last_decision
      self.backtracking = false
      self.decisions.delete_at(-1)
    end
  end

  def mark_current_position_visited
    self.path << self.position 
  end

  def last_decision
    self.decisions.last
  end

  def set_attributes
    self.character = 'C'
    self.blacklist =[]
    self.path = []
    self.decisions = []
  end

end