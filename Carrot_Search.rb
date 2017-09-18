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

end 