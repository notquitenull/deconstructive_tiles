require('general')

local base_item = {
	{
		type = "item",
		name = base_name .. "base",
		tooltip = "tba",
		icon = folder.graphics .. "tile-item.png",
		icon_size = 32,
		subgroup = "terrain",
		order = "c[landfill]-a[dirt]",
		stack_size = 1000000,
		place_as_tile = {
			result = base_name .. "base",
			condition_size = 1,
			condition = {"water-tile"}
		},
	},
	{
		type = "recipe",
		name = base_name .. "base",
		energy_required = 0.0011,
		enabled = true,
		ingredients = {},
		result = base_name .. "base",
		result_count = 500
	}
}

data:extend(base_item)
