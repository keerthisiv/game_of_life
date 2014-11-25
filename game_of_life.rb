class Grid

	attr_reader :rows, :columns, :current_grid

	def initialize(rows, columns)
		@rows = rows
		@columns = columns
		@current_grid = Array.new(rows, Array.new(columns, Cell.new(0)))
	end

end

class WorldTicker

#  def self.calculate_world(matrix)
#    i = 0
#    result = []
#    matrix.each do |row| 
#      j = 0
#      row.each do |cell|
#        matrix = get_matrix_for_this_cell
#        result <<  RuleCalculator.run_rules(matrix, i, j)
#        j += 1
#      end
#      i += 1
#    end
#    result
#  end

end

class MatrixGenerator

  def self.elements_above(matrix, index_x, index_y)
    elements = []
    if index_x > 0
      elements << matrix[index_x - 1][index_y]
      if index_y <= matrix.length - 1
        elements << matrix[index_x - 1][index_y + 1]
      end
      if index_y > 0 
        elements << matrix[index_x - 1][index_y - 1]
      end
    end
    elements.compact
  end
  
  def self.elements_on_sides(matrix, index_x, index_y)
    elements = []
    elements << matrix[index_x][index_y - 1]
    if index_y < matrix.length - 1
      elements << matrix[index_x][index_y + 1]
    end 
    elements
  end

  def self.generate_matrix(matrix, index_x, index_y)
    result_matrix = []
    if index_x + 1 <= matrix.length - 1
      result_matrix << matrix[index_x + 1][index_y]
      if index_y + 1 <= matrix.length -  1
        result_matrix << matrix[index_x + 1][index_y + 1]
        result_matrix << matrix[index_x][index_y + 1]
      end
    end

    if index_x - 1 >= 0 
      result_matrix << martix
    end
  end

end

class RuleCalculator
	def self.run_rules(matrix, index_x, index_y)
		neighbours = NeighbourCalculator.get_neighbours(matrix)
		me = matrix[index_x][index_y]
		if me == 1
			if neighbours > 1 && neighbours <= 3 
				1
			else
				0
			end
		else 
			if neighbours == 3
				1
			else
				0
			end
		end
	end
end

class NeighbourCalculator

	def self.get_neighbours(matrix)
		me = matrix[1][1]
		sum = matrix.flatten.inject(:+)
		sum - me
	end

end

class Cell

	attr_accessor :state

	def initialize(state)
		@state = state
	end

	def dead
		@state = 0
	end

	def alive
		@state = 1
	end

	def dead?
		@state == 0
	end

	def alive?
		@state == 1
	end

end

