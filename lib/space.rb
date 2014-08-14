class Space
	def initialize
		@str = " "
		@can_pass_though = true
	end

	def to_s
		@str
	end
end

class Player < Space
	def initialize
		super()
		@str = "@"
		@can_pass_though = false
	end
end

class Wall < Space
	def initialize(value)
		super()
		@str = value # one of these: - |
		@can_pass_though = false
	end
end

class PowerUp < Space
	attr_reader :health

	def initialize(health: 0)
		super()
		@str = "^"
		@health = health
	end
end