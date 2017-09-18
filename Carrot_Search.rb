class Carrot_Search 
	# 1. Find center, or the highest number closest to it 
	# 2. Set number to 0, increment carrot_count accordingly 
	# 3. Find the square next to it with the highest number 
	# 4. Repeat step 2 until it there are no adjacent squares other than 0's
	# 5. Break loop, return carrot_count 

def initialize(matrix)
	# set row and column variables to center  
	@current_row = 
	@current_column = 
	@matrix = matrix
	@carrot_count = 0 
end 

def find_possible_centers(size)
  size.odd? ? [size/2] : [(size/2)-1, size/2]
end 

def determine_center_position
  values = Hash.new 
  rows = find_possible_centers(@matrix.count)
  columns = find_possible_centers(@matrix[0].count)
  rows.each do |row| 
    columns.each do |column| 
      values[@matrix[row][column]] = [row, column]
    end 
  end 
  @current_row = values.max_by{ |k,v| k }[1][0]
  @current_column = values.max_by{ |k,v| k }[1][1]
end 

end 