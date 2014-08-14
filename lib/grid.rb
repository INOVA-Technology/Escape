class Grid

	attr_accessor :spaces

	def initialize(rows, columns)
		@rows = rows
		@columns = columns
		@spaces = []
	end

	class << self # these are for creating new maps

		def empty(rows, columns)
			a = self.new(rows, columns)
			a.rows.times do |row|
				a.columns.times do |col|
					a.spaces << Space.new
				end
			end
		end

		def from_map(rows, columns, map)
			a = self.new(rows, columns)
			map.chars.map do |c|
				next if c == "\n"
				a.spaces << case c
				when " "
					Space.new
				when "|", "-"
					Wall.new(c)
				when "@"
					Player.new
				when "%"
					PowerUp.new(health: 3)
				when "<", ">"
					Exit.new(c)
				else
					raise ArgumentError, "invalid character: #{c}"
				end
			end
			a
		end

	end # end class methods

	def [](r, c = nil)
		if c
			@spaces[@columns * r + c]
		else
			@spaces[r]
		end
	end

	def []=(r, c, other = nil)
		if other
			@spaces[@columns * r + c] = other
		else
			@spaces[r] = c			
		end
	end

	def left_of(r, c = nil)
		(c ? c -= 1 : r -= 1)
		(c ? [r, c] : r)
	end

	def right_of(r, c = nil)
		(c ? c += 1 : r += 1)
		(c ? [r, c] : r)
	end

	def above_of(r, c = nil)
		(c ? r -= 1 : r -= @columns)
		(c ? [r, c] : r)
	end

	def below_of(r, c = nil)
		(c ? r += 1 : r += @columns)
		(c ? [r, c] : r)
	end

	def in_direction_of_space(direction, r, c = nil)
		if c
			unless r < @rows && c < @columns
				nil
			end
		else
			if r < @rows * @columns
				case direction.to_sym
				when :l
					(c ? c -= 1 : r -= 1)
				when :r
					(c ? c += 1 : r += 1)
				when :u
					(c ? r -= 1 : r -= @columns)
				when :d
					(c ? r += 1 : r += @columns)
				else
					nil
				end
			else
				nil
			end
		end
	end

	def index_of(space)
		@spaces.index(space)
	end

	def player
		e = nil
		@spaces.each do |s|
			if s.is_a?(Player)
				e = s
				break
			end
		end
		e
	end

	def to_s
		almost_there = @spaces.each_slice(@columns).map do |row|
			row.map(&:to_s).join("")
		end
		almost_there.join("\n")
	end

end