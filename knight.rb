class Location
  attr_accessor :loc, :parent
  def initialize(start_pos, parent = nil)
    if start_pos.length == 2 && start_pos[0] > 0 && start_pos[0] < 9 && start_pos[1] > 0 && start_pos[1] < 9
      @x = start_pos[0]
      @y = start_pos[1]
      @loc = [@x,@y]
      @parent = parent
    else
      puts "Invalid starting position."
    end
  end

  def moves
    move_options = []
    move_options << [@x+1,@y+2] if @x+1 < 9 && @y+2 < 9
    move_options << [@x-1,@y+2] if @x-1 > 0 && @y+2 < 9
    move_options << [@x+1,@y-2] if @x+1 < 9 && @y-2 > 0
    move_options << [@x-1,@y-2] if @x-1 > 0 && @y-2 > 0
    move_options << [@x+2,@y+1] if @x+2 < 9 && @y+1 < 9
    move_options << [@x+2,@y-1] if @x+2 < 9 && @y-1 > 0
    move_options << [@x-2,@y+1] if @x-2 > 0 && @y+1 < 9
    move_options << [@x-2,@y-1] if @x-2 > 0 && @y-1 > 0
    return move_options
  end
end #Location

def knight_moves(start, finish)
  queue = [start]
  visited = [start.loc]
  path = []

  until queue.empty?
    current = queue.shift
    unvisited = current.moves.select {|move| !visited.include?(move)}
    if unvisited.include? finish.loc
      path.unshift(current.loc)
      break
    end
    unvisited.each do |move|
      visited << move
      queue << Location.new(move,current)
    end
  end

  trace = current.parent
  until trace == nil
    path.unshift(trace.loc)
    trace = trace.parent
  end

  path << finish.loc

  puts
  puts "It takes #{path.length} moves to get from #{start.loc} to #{finish.loc}."
  puts "The moves are: "
  path.each do |move|
    puts "#{move}"
  end
end #knight_moves

a = Location.new [1,1]
b = Location.new [5,5]
c = Location.new [6,8]
d = Location.new [2,1]

knight_moves(a,b)
knight_moves(a,c)
knight_moves(b,c)
knight_moves(a,d)
knight_moves(d,b)


# breadth first search*
# start at node
# - mark adjacent points as visited
# - add adjacent points to queue
# once all adjacent points are added, move to first item in queue
# - mark unvisited adjacent points as visited
# - add those points to the queue
# move to next item in queue until the queue is empty


# depth first search
# start at node
# - add to stack
# - move to that node
# - mark as visited
# look at adjacent points
# - pick one
# - add to stack
# - move to that node
# - mark as visted
# repeat until you run out of adjacent points
# - when you run out, remove last item in stack
# - move to previous item in stack
# - at previous items, check for unvisted adjacent points
# - repeat until stack is empty
