class Carrot_Search 
  attr_accessor :current_row, :current_column, :matrix, :carrot_count
  # 1. Find center, or the highest number closest to it 
  # 2. Set number to 0, increment carrot_count accordingly 
  # 3. Find the square next to it with the highest number 
  # 4. Repeat step 2 until it there are no adjacent squares other than 0's
  # 5. Break loop, return carrot_count 

def initialize(matrix)
  # set row and column variables to center 
  @current_column = 0
  @current_row = 0
  @matrix = matrix
  @carrot_count = 0 
  @rabbit_asleep = false 
end 

def find_possible_centers(size)
  size.odd? ? [size/2] : [(size/2)-1, size/2]
end 

def determine_position(rows, columns, start=false)
    values = Hash.new 
    rows.each do |row| 
      columns.each do |column| 
        values[@matrix[row][column]] = [row, column]
      end 
    end 
  p values
  @current_row = values.max_by{ |k,v| k }[1][0]
  @current_column = values.max_by{ |k,v| k }[1][1]
end 

def possible_moves 
  moves = Hash.new 
  if (@current_row + 1) <= @matrix.length 
    moves[@matrix[@current_row + 1][@current_column]] = [(@current_row + 1),@current_column]
  end 
  if (@current_row - 1) >= 0
    moves[@matrix[@current_row - 1][@current_column]] = [(@current_row - 1),@current_column]
  end 
  if (@current_column + 1) <= @matrix[0].length 
    moves[@matrix[@current_row][@current_column + 1]] = [@current_row,(@current_column + 1)]
  end
  if (@current_column - 1) >= 0 
    moves[@matrix[@current_row][@current_column - 1]] = [@current_row,(@current_column - 1)]
  end 
  @current_row = moves.max_by{ |k,v| k }[1][0] 
  @current_column = moves.max_by{ |k,v| k }[1][1]
end 

def eat_carrot 
  square = @matrix[@current_row][@current_column]
  if square == 0 
    return @rabbit_asleep = true 
  end 
  @carrot_count += square 
  @matrix[@current_row][@current_column] = 0 
end 

def runner
  garden = @matrix
  start_rows = find_possible_centers(garden.length)
  start_columns = find_possible_centers(garden[0].length)
  determine_position(start_rows, start_columns)
  until @rabbit_asleep 
    eat_carrot
    possible_moves
  end 
  @carrot_count
end 

end 

test = Carrot_Search.new([[5,7,8,6,3],[0,0,7,0,4],[4,6,3,4,9],[3,1,0,5,8]])
test.runner 

