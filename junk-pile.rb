#	class Fat < Chingu::GameObject
#		attr_reader :hunger
#		traits :timer, :velocity, :collision_detection
#		def setup
#			@image = Gosu::Image['fat.png']
#			@hunger = 0
#			every(3000, :name => :hunger) {@hunger += 1}
#			(@hungry = Chingu::Text.create('Hungry!', :x => @x - 24, :y => @y - 48, :align => :center)).hide!
#			@acceleration_y = 0.4
#			@can_jump = false
#			@can_check_for_jump = true
#			self.input = {
#				:holding_a => lambda {@acceleration_x -= 1},
#				:holding_d => lambda {@acceleration_x += 1},
#				:released_w => :jump,
#				:holding_s => :duck,
#				:pressed_space => :use_ability}
#		end
#		def update
#			@hungry.x, @hungry.y = @x - 24, @y - 48
#			@hungry.show! if @hunger > 5
#			@acceleration_x *= 0.5
#			@velocity_x *= 0.02
#			@velocity_x = 0 if @velocity_x.abs < 0.01
#			@velocity_y = -@velocity_y / 3 if @y >= $window.height * 0.95
#			@y = $window.height * 0.95 if @y > $window.height * 0.95
#			(@can_jump = true if ($window.height - @y) < 25) if @can_check_for_jump
#		end
#		def jump
#			return unless @can_jump
#			@can_jump = false
#			@velocity_y -= 5
#			@can_check_for_jump = false
#			after(1000) {@can_check_for_jump = true}
#		end
#		def duck; end
#		def use_ability; end
#	end
#	class Skinny < Chingu::GameObject
#		attr_reader :health
#		traits :timer, :velocity, :collision_detection
#		def setup
#			@image = Gosu::Image['skinny.png']
#			@health = 10
#			(@hurt = Chingu::Text.create('Ouch!', :x => @x - 24, :y => @y - 48, :align => :center)).hide!
#			@acceleration_y = 0.4
#			@can_jump = false
#			@can_check_for_jump = true
#			self.input = {
#				:holding_left => lambda {@acceleration_x -= 3},
#				:holding_right => lambda {@acceleration_x += 3},
#				:released_up => :jump,
#				:holding_down => :duck,
#				:pressed_kbd0 => :grab}
#		end
#		def update
#			@acceleration_x *= 0.5
#			@velocity_x *= 0.02
#			@velocity_x = 0 if @velocity_x.abs < 0.01
#			@velocity_y = -@velocity_y / 3 if @y >= $window.height * 0.95
#			@y = $window.height * 0.95 if @y > $window.height * 0.95
#			(@can_jump = true if ($window.height - @y) < 25) if @can_check_for_jump
#		end
#		def jump
#			return unless @can_jump
#			@can_jump = false
#			@velocity_y -= 7
#			@can_check_for_jump = false
#			after(1000) {@can_check_for_jump = true}
#		end
#		def duck; end
#		def grab; end
#	end

	class Over < Chingu::GameState
		def setup
			@input = {:return => lambda {2.times {pop_game_state}}}
		end
	end
	
					# let's try to gracefully push the player out of the block he is on/in.
				# player.y -= bounding_box.bottom - block.bounding_box.top if bounding_box.bottom > block.bounding_box.top and bounding_box.centerx > block.bounding_box.left and bounding_box.centerx < block.bounding_box.right
				# player.x -= (bounding_box.right - block.bounding_box.left) if (bounding_box.right) > block.bounding_box.left and bounding_box.centery > block.bounding_box.top and bounding_box.centery < block.bounding_box.bottom
				# up_zone = Chingu::Rect.new(block.bounding_box.centerx, block.bounding_box.top - block.bounding_box.height / 4, block.bounding_box.width, block.bounding_box.height / 4)
				# left_zone = Chingu::Rect.new(block.bounding_box.left, block.bounding_box.centery, block.bounding_box.width / 4, block.bounding_box.height)
				# right_zone = Chingu::Rect.new(block.bounding_box.right, block.bounding_box.centery, block.bounding_box.width / 4, block.bounding_box.height)
				# @y -= bounding_box.bottom - block.bounding_box.top if bounding_box.collide_rect?(up_zone)
				# @x -= bounding_box.right - block.bounding_box.left if bounding_box.collide_rect?(left_zone) and not hit_up_zone
				# @x += bounding_box.left - block.bounding_box.right if bounding_box.collide_rect?(right_zone) and not hit_up_zone
#				quadrants = {}
#				quadrants[:one] = Chingu::Rect.new(
#					block.bounding_box.centerx - (block.bounding_box.width / 4),
#					block.bounding_box.centery - (block.bounding_box.height / 4),
#					block.bounding_box.width / 1.5,
#					block.bounding_box.width / 1.5)
#				quadrants[:two] = Chingu::Rect.new(
#					block.bounding_box.centerx + (block.bounding_box.width / 4),
#					block.bounding_box.centery - (block.bounding_box.height / 4),
#					block.bounding_box.width / 1.5,
#					block.bounding_box.width / 1.5)
#				quadrants[:three] = Chingu::Rect.new(
#					block.bounding_box.centerx + (block.bounding_box.width / 4),
#					block.bounding_box.centery + (block.bounding_box.height / 4),
#					block.bounding_box.width / 2,
#					block.bounding_box.width / 2)
#				quadrants[:four] = Chingu::Rect.new(
#					block.bounding_box.centerx - (block.bounding_box.width / 4),
#					block.bounding_box.centery + (block.bounding_box.height / 4),
#					block.bounding_box.width / 2,
#					block.bounding_box.width / 2)
#				in_quadrants = []
#				quadrants.each_pair do |key, quadrant|
#					in_quadrants << key if bounding_box.collide_rect?(quadrant)
#				end
#				puts in_quadrants
#				if in_quadrants.include?(:one) and in_quadrants.include?(:two) then @y -= bounding_box.bottom - block.bounding_box.top
#				elsif in_quadrants.include?(:one) and in_quadrants.include?(:four) then @x -= bounding_box.right - block.bounding_box.left
#				elsif in_quadrants.include?(:two) and in_quadrants.include?(:three) then @x += block.bounding_box.right - bounding_box.left
#				end
