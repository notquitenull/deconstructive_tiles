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

local function deconstructive_tile_template(name, graphics) 
	return {{	
		type = "tile",
		name = base_name .. name,
		needs_correction = false,
		minable = {hardness = 0, mining_time = 0},
		collision_mask = {"layer-33"},
		walking_speed_modifier = 1,
		layer = 33,
		variants = tile_graphics(graphics),
		map_color = {r = 150, g = 10, b = 10},
		pollution_absorption_per_second = 0,
		check_collision_with_entities = true
	}}
end

local cautious_tile = deconstructive_tile_template(tile_variants.cautious, tile_variants.basic)
cautious_tile[1].collision_mask = {"layer-33", "water-tile", "floor-layer", "object-layer", "transport-belt-layer", "ghost-layer"} 
data:extend(deconstructive_tile_template(tile_variants.basic, tile_variants.basic))
data:extend(cautious_tile)

