class Grid

	attr_reader :rows, :columns, :current_grid

	def initialize(rows, columns)
		@rows = rows
		@columns = columns
		@current_grid = Array.new(rows, Array.new(columns, Cell.new(0)))
	end

	def populate_grid(no_of_cells)
		(1..no_of_cells).each do |cell|
			@current_grid[@rows - cell][cell] = Cell.new(1) 
		end	
	end

end

class WorldTicker

	def self.calculate_world(matrix)
		result = matrix.dup
		matrix.each {|row| 
			row.each {|cell|

			}
		}
	end

end

class RuleCalculator
	def self.run_rules(matrix)
		neighbours = NeighbourCalculator.get_neighbours(matrix)
		me = matrix[1][1]
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

