class Carrot_Search 
  # 1. Find center, or the highest number closest to it 
  # 2. Set number to 0, increment carrot_count accordingly 
  # 3. Find the square next to it with the highest number 
  # 4. Repeat step 2 until it there are no adjacent squares other than 0's
  # 5. Break loop, return carrot_count 

def initialize(matrix)
  @matrix = matrix
  @carrot_count = 0 
  @rabbit_asleep = false 
end 

def find_possible_centers(size)
  size.odd? ? [size/2] : [(size/2)-1, size/2]
end 

def determine_position(rows, columns)
    values = Hash.new 
    rows.each do |row| 
      columns.each do |column| 
        values[@matrix[row][column]] = [row, column]
      end 
    end 
  highest_value_square(values)
end 

def highest_value_square(values)
  @current_row = values.max_by{ |k,v| k }[1][0]
  @current_column = values.max_by{ |k,v| k }[1][1]
end 

def possible_moves 
  values = Hash.new 
  if (@current_row + 1) <= @matrix.length 
    values[@matrix[@current_row + 1][@current_column]] = [(@current_row + 1),@current_column]
  end 
  if (@current_row - 1) >= 0
    values[@matrix[@current_row - 1][@current_column]] = [(@current_row - 1),@current_column]
  end 
  if (@current_column + 1) <= @matrix[0].length 
    values[@matrix[@current_row][@current_column + 1]] = [@current_row,(@current_column + 1)]
  end
  if (@current_column - 1) >= 0 
    values[@matrix[@current_row][@current_column - 1]] = [@current_row,(@current_column - 1)]
  end 
  highest_value_square(values)
end 

def eat_carrot 
  square = @matrix[@current_row][@current_column]
  if square == 0 
    return @rabbit_asleep = true 
  end 
  @carrot_count += square 
  @matrix[@current_row][@current_column] = 0 
end 

def set_starting_position
  start_rows = find_possible_centers(@matrix.length)
  start_columns = find_possible_centers(@matrix[0].length)
  determine_position(start_rows, start_columns)
end 

def runner
  set_starting_position
  until @rabbit_asleep 
    eat_carrot
    possible_moves
  end 
  @carrot_count
end 

end 

test = Carrot_Search.new([[5,7,8,6,3],[0,0,7,0,4],[4,6,3,4,9],[3,1,0,5,8]])
test.runner  

