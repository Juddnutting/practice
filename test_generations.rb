require 'minitest/autorun'
require './generations'

class TestGenerations < Minitest::Test 

	def setup
		@gen= Generations.new()
		@gen.board = [[0,1,1,0,0],[0,1,1,1,0],[1,1,0,0,0],[1,0,0,1,0],[1,1,0,0,1]]
		@correct_board = [[0,1,0,1,0],[0,0,0,1,0],[1,0,0,1,0],[0,0,1,0,0],[1,1,0,0,0]]
	end

	def test_size_is_correct
		assert_equal 5, @gen.height
	end

	def test_edge_cases_not_valid?
		assert_equal false, @gen.valid?("left",0,0)
		assert_equal false, @gen.valid?("right",0,@gen.width-1)
		assert_equal false, @gen.valid?("up",0,0)
		assert_equal false, @gen.valid?("down",@gen.height-1,0)
	end

	def test_adjacent_values
		assert_equal 0, @gen.get_adjacent_value('left',0,1)
		assert_equal 1, @gen.get_adjacent_value('right',0,1)
		assert_equal 1, @gen.get_adjacent_value('upleft',2,4)
	end

	def test_sum_values
		assert_equal 2, @gen.sum_of_adjacent_values(0,0)
		assert_equal 5, @gen.sum_of_adjacent_values(3,1)
	end

	def test_results_of_score
		assert_equal 0, @gen.result(0,1)
		assert_equal 0, @gen.result(1,1)
		assert_equal 1, @gen.result(2,1)
		assert_equal 1, @gen.result(3,1)
		assert_equal 0, @gen.result(4,1)
		assert_equal 1, @gen.result(3,0)
		assert_equal 0, @gen.result(2,0)
		assert_equal 0, @gen.result(1,0)
	end

	def test_final_generation
		assert_equal @correct_board, @gen.next_generation
	end

end