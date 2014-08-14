class Delegate

	attr_accessor :grid

	def initialize(grid)
		@grid = grid
	end

	def parse(input)
		case input
		when "u"
			move_player("u")
		when "d"
			move_player("d")
		when "l"
			move_player("l")
		when "r"
			move_player("r")
		when "q", "quit"
			exit
		else
			puts "What?"
		end
	end

	def move_player(direction)
		player_pos = @grid.find_player
		other = case direction.to_sym
				when :u
					@grid.above_of(player_pos)
				when :d
					@grid.below_of(player_pos)
				when :l
					@grid.left_of(player_pos)
				when :r
					@grid.right_of(player_pos)
				else
					raise ArgumentError, "invalid direction: #{c}"
				end
		if other.class == (Space)
			puts "good"
		else
			puts "Nope!"
		end
	end

end