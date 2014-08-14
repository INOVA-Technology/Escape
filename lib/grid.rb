class Grid

	attr_accessor :spaces

	def initialize(rows, columns)
		@rows = rows
		@columns = columns
		@spaces = []
	end

	def self.empty(rows, columns)
		a = self.new(rows, columns)
		a.rows.times do |row|
			a.columns.times do |col|
				a.spaces << Space.new
			end
		end
	end

	def self.from_map(rows, columns, map)
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
			when "^"
				PowerUp.new(health: 3)
			else
				raise ArgumentError, "invalid character: #{c}"
			end
		end
		a
	end

	def [](r, c = nil)
		if c
			@spaces[@columns * r + c]
		else
			@spaces[r]
		end
	end

	def left_of(r, c = nil)
		(c ? c -= 1 : r -= 1)
		self[r, c]
	end

	def right_of(r, c = nil)
		(c ? c += 1 : r += 1)
		self[r, c]
	end

	def above_of(r, c = nil)
		(c ? r -= 1 : r -= @columns)
		self[r, c]
	end

	def below_of(r, c = nil)
		(c ? r += 1 : r += @columns)
		self[r, c]
	end

	def find_player
		e = nil
		i = 0
		@spaces.each do |s|
			if s.is_a?(Player)
				e = i
				break
			end
			i += 1
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