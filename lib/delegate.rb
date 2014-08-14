class Delegate

	attr_accessor :grid

	def initialize(grid)
		@grid = grid
	end

	def parse(input)
		case input
		when /^(up?|d(own)?|l(eft)?|r(ight)?)$/
			move_player(input[0])
		when "q", "quit"
			exit
		else
			puts "What?"
		end
	end

	def move_player(direction)
		player_pos = @grid.index_of(@grid.player)
		new_pos = @grid.in_direction_of_space(direction, player_pos)
		new_space = @grid[new_pos]

		if new_space.can_pass_through?
			use_powerup(new_space) if new_space.is_a?(PowerUp)
			@grid[new_pos] = grid.player
			@grid[player_pos] = Space.new
		else
			puts "Nope!"
		end
	end

	def use_powerup(powerup)
		grid.player.health += powerup.health
		puts "+#{powerup.health}! You have #{grid.player.health} health!"
	end

end