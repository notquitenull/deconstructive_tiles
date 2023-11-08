require('general')

local function item_template(name)
return {
		{
			type = "item",
			name = base_name .. name,
			tooltip = "tba",
			icon = folder.graphics .. name .. "-item.png",
			icon_size = 128,
			subgroup = "terrain",
			order = "c[landfill]-a[dirt]",
			stack_size = 1000000,
			place_as_tile = {
				result = base_name .. name,
				condition_size = 1,
				condition = {"water-tile"}
			},
		},
		{
			type = "recipe",
			name = base_name .. name,
			energy_required = 0.0011,
			enabled = true,
			ingredients = {},
			result = base_name .. name,
			result_count = 500
		}
	}
end

data:extend(item_template(tile_variants.basic))
data:extend(item_template(tile_variants.cautious))
data:extend(item_template(tile_variants.ghost_only))
