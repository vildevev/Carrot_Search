class Carrot_Search 
  # 1. Find center, or the highest number closest to it 
  # 2. Set carrot_count to 0, increment count accordingly 
  # 3. Find the square next to it with the highest number 
  # 4. Repeat step 2 until it there are no adjacent squares other than 0's
  # 5. Break loop, return carrot_count 

# Takes nested array as an argument, creates instance variable 'matrix'
def initialize(matrix)
  @matrix = matrix
  @carrot_count = 0 
  @rabbit_asleep = false 
end 

# Will return middle indeces if length is odd, finds the closest possible if even
def find_possible_centers(size)
  size.odd? ? [size/2] : [(size/2)-1, size/2]
end 

# Determines possible starting positions, feeds them into a values hash
def determine_center_position(rows, columns)
    values = Hash.new 
    rows.each do |row| 
      columns.each do |column| 
        values[@matrix[row][column]] = [row, column]
      end 
    end 
  highest_value_square(values)
end 

# Determines which of the possible squares has the highest carrot count, moves rabbit to that square
def highest_value_square(values)
  @current_row = values.max_by{ |k,v| k }[1][0]
  @current_column = values.max_by{ |k,v| k }[1][1]
end 

# Calculates possible moves for the rabbit. Can't go outside of matrix.
def possible_moves 
  row = @current_row
  column = @current_column
  values = Hash.new 
  if (row + 1) <= @matrix.length 
    values[@matrix[row + 1][column]] = [(row + 1),column]
  end 
  if (row - 1) >= 0
    values[@matrix[row - 1][column]] = [(row - 1),column]
  end 
  if (column + 1) <= @matrix[0].length 
    values[@matrix[row][column + 1]] = [row,(column + 1)]
  end
  if (column - 1) >= 0 
    values[@matrix[row][column - 1]] = [row,(column - 1)]
  end 
  highest_value_square(values)
end 

# Increments carrot_count, sets value of square to 0. If rabbit can only move to other O-squares, falls asleep.
def eat_carrot 
  square = @matrix[@current_row][@current_column]
  return @rabbit_asleep = true if square == 0 
  @carrot_count += square 
  @matrix[@current_row][@current_column] = 0 
end 

# Determines starting positions by using center-helper functions
def set_starting_position
  start_rows = find_possible_centers(@matrix.length)
  start_columns = find_possible_centers(@matrix[0].length)
  determine_center_position(start_rows, start_columns)
end 

# Coordinates all the actions. Breaks when rabbit is asleep. Returns carrot_count
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
test.runner # Returns 27 as expected 
