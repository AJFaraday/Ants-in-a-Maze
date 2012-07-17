class AlanAnt < Ant

  # both expect a single array, column, and row e.g. [0,0]
  attr_accessor :last_position
  attr_accessor :last_decision
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
      self.path = []
      self.last_decision = self.position
    end
    if backtracking == true or self.last_decision.nil?
      self.blacklist << self.position 
    end
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
    self.backtracking = false if self.position == self.last_decision
  end

  def mark_current_position_visited
    self.path << self.position 
  end

  def set_attributes
    self.character = 'A'
    self.blacklist =[]
    self.path = []
  end

end










class AndrewAnt < Ant

  def visited_without_count
    self.visited.collect{|slot| slot[0..1]}
  end

  def move(iteration=0)
    return if self.stop_if_finished(iteration)
   
    self.mark_current_position_visited
    options = GridArray.current.options_from(position[0],position[1])
    
    if options.all?{|option| self.visited_without_count.include?(option) }
      # all options have been previously visited
      options = self.visited.select{|x| options.include?(x[0..1]) }
      next_pos = options.sort{|a,b| a[2] <=> b[2]}.first
      set_position next_pos[0], next_pos[1]
    else
      self.visited_without_count.each{|slot| options.delete(slot)}
      next_pos = options[rand(options.length)]
      set_position next_pos[0], next_pos[1]   
    end
  end

  def mark_current_position_visited
    if visited.any?{|slot| slot[0] == self.position[0] and slot[1] == self.position[1]}
      pos = visited.select{|slot| slot[0] == self.position[0] and slot[1] == self.position[1]}[0]
      pos[2] = pos[2].succ
    else
      self.visited << self.position.concat([1])
    end
  end

  def set_attributes
    self.character = 'J'
  end

end
