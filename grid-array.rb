class GridArray < Array

  def GridArray.generate_empty(columns, rows)
    result = GridArray.new
    rows.times do 
      result << Array.new(columns, 0)
    end
    result
  end

  def GridArray.current
    arrays = [] 
    ObjectSpace.each_object(GridArray){|grid| arrays << grid}
    arrays.last
  end

  # probability(prob) expresses 1 in that number
  def GridArray.generate_random(columns, rows, prob)
    result = GridArray.new
    rows.times do |row|
      r = []
      columns.times{r << ((rand(prob) < 1) ? 1 : 0 ) }
      result << r
    end
    result
  end

  def to_code
    puts 'GridArray.new(['
    self.each do |row|
      print '  ['
        print row.join(',')
      puts '],'
    end
    puts '])'
  end
  
  def slot_accessible?(c, r)
    if self[r] and self[r][c]
      ![1,true].any?{|x| self[r][c] == x}
    else
      false
    end
  end

  def options_from(c, r)
    adjacent = [
      [(c-1),r], 
      [(c+1),r],
      [c,(r-1)],
      [c,(r+1)]
    ]
    options = []
    adjacent.each do |slot|
      if slot_accessible?(slot[0],slot[1]) and (0..self.width).include?(slot[0]) and (0..self.height).include?(slot[1])
        options << slot
      end
    end
    options
  end
  
  def width
    self.first.length
  end
 
  def height
    self.length
  end

  attr_accessor :actual_slots

  def passable_slots
    if self.actual_slots.nil?
      slots = []
      self.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          slots << [column_index, row_index] if ![true,1].any?{|x| x == cell} 
        end
      end
      self.actual_slots = slots
    else
      Array.new(self.actual_slots)
    end
  end




  def present
    s = ""

    s << present_border

    self.each_with_index do |row, row_index|
      s << '|'
      row.each_with_index do |cell, column_index|
        if [1,true].any?{|x| cell == x}
          s << '#'
        else
          resident_ants = Ant.all.select{|ant| ant.at?(column_index,row_index)}
          if resident_ants.length == 1
            s << resident_ants.first.character
          elsif resident_ants.length > 1
            s << '*'
          else
            s << ' '
          end
        end
      end
      s << "|\r\n"
    end

    s << present_border
    puts s
  end

  def present_border
    #print '+'
    #self.first.size.times{print '-'}
    #puts '+'
    "+#{'-'*self.first.size}+\r\n"
  end

end
