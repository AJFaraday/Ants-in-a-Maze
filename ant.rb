class Ant

  # Expects an array of arrays, column, row, visits e.g. [[0,0,2],[0,1,1]]
  attr_accessor :visited
  attr_accessor :to_visit

  # Position expressed as array: eg: [0,0]
  attr_accessor :at_row
  attr_accessor :at_column
  attr_accessor :character
  attr_accessor :finished_at


  def self.generate(c, r, multiple=1)
    results = []
    multiple.times do
      a = self.new
      a.character = '.'
      a.visited = []
      available = GridArray.current.passable_slots.to_a
      a.to_visit = available
      a.set_position(c, r)
      a.set_attributes if a.respond_to?(:set_attributes)
      results << a
      a
    end
    return results if results.length > 1
  end

  def self.all
    a = []
    ObjectSpace.each_object(self){|ant| a << ant}
    a
  end

  def Ant.move_all(iteration = 0)
    ObjectSpace.each_object(Ant){|ant| ant.move(iteration)}
  end

  def Ant.all_finished?
    Ant.all.all?{|ant| !ant.finished_at.nil?}
  end

  def Ant.percent_finished(percent)
    Ant.all.collect{|ant| !ant.finished_at.nil?}.percent_true >= percent
  end

  def set_position(c, r)
    self.at_row = r
    self.at_column = c
    self
  end

  def position
    [at_column, at_row]
  end

  def at?(query_column, query_row)
    at_row == query_row and at_column == query_column
  end

  # This method is here to avoid no method errors, 
  # but currently there is no base class movement algorithm.
  def move
    puts "No move method for base class, Ant."
  end

  def stop_if_finished(iteration=0)
    self.to_visit.delete(self.position)
    if to_visit.empty?
      self.finished_at = iteration if self.finished_at.nil?
      $display_string << "#{self.identify} has visited everywhere, iteration: #{self.finished_at} \r\n"
      return true
    else
      $display_string << "#{self.identify} remaining: #{self.to_visit.length}\r\n"
      return false
    end
  end
 
  def identify
    "#{self.class.name}(#{self.character}) at #{self.position.inspect} " 
  end

end
