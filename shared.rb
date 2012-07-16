require 'grid-array'
require 'ant'
require 'clever-ant'
require 'dumb-ants'
require 'named-ants'

def generate_ants(c=0,r=0,multiple=1)
    AndrewAnt.generate(c,r,multiple)
    AlanAnt.generate(c,r,multiple)
    DumbAnt.generate(c,r,multiple)
    LessDumbAnt.generate(c,r,multiple)
    CleverAnt.generate(c,r,multiple)
end
 
# percent is the percentage of ants who have to have explored every space before the script ends
def run_test(maze, interval=nil, percent=nil)
  i = 1
  $percent = percent 
  $slots = maze.passable_slots.count

  loop do 
    $display_string = ""
    sleep(interval) unless interval.nil?
    Ant.move_all(i)
    maze.present
    puts $display_string
    i = i + 1
    if ($percent and Ant.percent_finished($percent)) or Ant.all_finished?
      #Ant.all.each{|ant| puts ant.inspect}
      show_final_result
      return
    end
  end
end

def show_final_result
  result = "\r\n"
  result << "#######################################\r\n"
  result << "############ Final Result #############\r\n"
  result << "#######################################\r\n\r\n"
  if $percent
    result << "Race finished when #{$percent}% of the ants had explored everywhere.\r\n"
  else
    result << "All ants have explored everywhere.\r\n" 
  end
  result << "There were #{$slots} slots to explore.\r\n"
  [DumbAnt,LessDumbAnt,AlanAnt,AndrewAnt,CleverAnt].each do |klass|
    ants = klass.all
    unless ants.empty?
      iterations = ants.collect{|ant| ant.finished_at}.compact
      if iterations.empty?
        class_table = ants.collect{|a| a.to_visit.count}.sort
        result << "#{klass} - No ants finished - Best: #{class_table.first} - Worst: #{class_table.last} (remaining) \r\n"
      else
        result << "#{klass} - Finished: #{iterations.length} - First: #{iterations.min} - Last: #{iterations.max} - Average: #{iterations.average} \r\n"
      end
    end
  end  
  puts result
end

class Array 

  def sum
    result = 0
    self.each{|x| result += x.to_f }
    result
  end

  def average
    self.sum / self.length.to_f
  end

  def percent_true
    tf = [0, 0]
    self.collect{|x| x ? tf[0] += 1 : tf[1] += 1}
    if tf == [0,0]
      puts 'empty array'
      return 0
    else
      tf[0].to_f/(tf[1]+tf[0]).to_f * 100
    end
  end

end  

