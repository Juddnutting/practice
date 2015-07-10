class Generations
	attr_accessor :board, :scored_board, :new_board
	attr_reader :height, :width, :moves	

	def initialize(input_matrix: nil, size: 5)
		if input_matrix
			@board = input_matrix
			@height = input_matrix.length
			@width = input_matrix[0].length
		else
			@board = Array.new(size) { Array.new(size,0)}
			@height = size
			@width = size
		end
		@moves = %w(left right up down upleft upright downleft downright)
		@scored_board = Array.new(height) { Array.new(width,nil)}
		@new_board = Array.new(height) { Array.new(width,nil)}

	end

	def test_board
		self.board = [[0,1,1,0,0],[0,1,1,1,0],[1,1,0,0,0],[1,0,0,1,0],[1,1,0,0,1]]
	end

	def print_board
		puts 'board'
		board.each {|line| p line}
		puts ''
	end

	def print_scored_board
		puts "scored board"
		scored_board.each {|line| p line}
		puts ''
	end

	def print_new_board
		new_board.each {|line| p line}
		puts ''
	end

	def randomize_board
		self.board = board.map do |row|
			row.map { |col| [0,1].sample}
		end
	end

	def sum_of_adjacent_values(x,y)
		sum = 0
		moves.each do |move|
			sum += get_adjacent_value(move,x,y)
		end
		sum
	end

	def next_generation
		# scored board not required but was handy in testing
		self.new_board = Array.new(height) { Array.new(width,nil)}
		self.scored_board = Array.new(height) { Array.new(width,nil)}
		self.board.each_with_index do |row, row_x|
			row.each_with_index do |cell_value, col_y|
				score = sum_of_adjacent_values(row_x,col_y)
				scored_board[row_x][col_y] = score
				new_board[row_x][col_y] = result(score,cell_value)
				
			end
		end
		self.board = @new_board

	end

	def result(score, alive)
		if alive == 1
			if score <= 1
				return 0
			elsif score <= 3
				return 1
			elsif score > 3
				return 0
			end
		elsif alive == 0 && score == 3
			return 1
		else
			return 0
		end
	end

	def get_adjacent_value(move,x,y)
		if valid?(move,x,y)
			return case move
			when 'left' then board[x][y-1]
			when 'right' then board[x][y+1]
			when 'up' then board[x-1][y]
			when 'down' then board[x+1][y]
			when 'upleft' then board[x-1][y-1]
			when 'upright' then board[x-1][y+1]
			when 'downleft' then board[x+1][y-1]
			when 'downright' then board[x+1][y+1]
			else 0
			end
		else
			return 0
		end
	end

	def valid?(move,x,y)
		if move == 'left' && y<=0
			return false
		elsif move == 'right' && y>=width-1
			return false
		elsif move == 'up' && x<=0
			return false
		elsif move == 'down' && x>=height-1
			return false
		elsif move == 'upleft' && (x<=0 || y<=0)
			return false
		elsif move == 'upright' && (x<=0 || y>=width-1)
			return false
		elsif move == 'downleft' && (x>=height-1 || y<=0)
			return false
		elsif move == 'downright' && (x>=height-1 || y>=width-1)
			return false
		else
			return true
		end
	end

	def run(num_of_generations = 1)

		num_of_generations.times do 
			next_generation
		end
	end


end # class end
