class Space
	attr_reader :can_pass_through
	alias_method :can_pass_through?, :can_pass_through

	def initialize
		@str = " "
		@can_pass_through = true
	end

	def to_s
		@str
	end
end

class Player < Space
	attr_accessor :health

	def initialize
		super()
		@str = "@"
		@health = 15
		@can_pass_through = false
	end
end

class Wall < Space
	def initialize(value)
		super()
		@str = value # one of these: - |
		@can_pass_through = false
	end
end

class PowerUp < Space
	attr_reader :health

	def initialize(health: 0)
		super()
		@str = "%"
		@health = health
	end
end