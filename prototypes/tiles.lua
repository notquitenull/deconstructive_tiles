require('general')

local function tile_graphics(variant)
	return {
		main = {
			{
				picture = folder.graphics .. variant .. "-main.png",
				count = 16,
				size = 1
			}
		},
		inner_corner = {
			picture = folder.graphics .. variant .. "-inner-corner.png",
			count = 1,
		},
		outer_corner = {
			picture = folder.graphics .. variant .. "-outer-corner.png",
			count = 1,
		},
		side = {
			picture = folder.graphics .. variant .. "-side.png",
			count = 1,
		},
		u_transition = {
			picture = folder.graphics .. variant .. "-u.png",
			count = 1,
		},
		o_transition = {
			picture = folder.graphics .. variant .. "-o.png",
			count = 1,
		}
	}
end

local function deconstructive_tile_template(name) 
	return {{	
		type = "tile",
		name = base_name .. name,
		needs_correction = false,
		minable = {hardness = 0, mining_time = 0},
		collision_mask = { "ground-tile" },
		walking_speed_modifier = 1,
		layer = 68,
		variants = tile_graphics(name),
		map_color = {r = 139, g = 69, b = 19},
		pollution_absorption_per_second = 0
	}}
end

data:extend(deconstructive_tile_template("base"))

