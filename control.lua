require('general')

function deconstruct_on_tile(surface, player, tile, offest)
	local pos = {tile.position.x + offest, tile.position.y + offest}
	local entities = surface.find_entities_filtered{position = pos}
	for i = 1, #entities do 
		entities[i].order_deconstruction(player.force, player)
	end
end
function deconstruct_on_ghost(surface, player, tile)
	deconstruct_on_tile(surface, player, tile, 0)
end

local function deconstructive_tile_built(event) 
	if event.tile.name == base_name .. "base" then 
		local surface = game.get_surface(event.surface_index)
		local player = game.get_player(event.player_index)
		
		for i = 1, #event.tiles do 
			deconstruct_on_tile(surface, player, event.tiles[i], 0.5)
		end
	elseif event.tile.name == base_name .. tile_variants.cautious then
		game.print("replacing tile")
		local surface = game.get_surface(event.surface_index)
		for i = 1, #event.tiles do
			surface.set_tiles({{name=base_name .. tile_variants.basic, position = event.tiles[i].position}})
		end
	end
end

local function deconstructive_tile_ghost(event) 
	if event.created_entity.name == "tile-ghost" then
		if event.created_entity.ghost_name == base_name .. tile_variants.basic or
		   event.created_entity.ghost_name == base_name .. tile_variants.cautious then
			local surface = game.get_surface(event.created_entity.surface_index)
			local player = game.get_player(event.player_index)
			
			deconstruct_on_ghost(surface, player, event.created_entity)
		end
	end
end

script.on_event(defines.events.on_player_built_tile, deconstructive_tile_built)
script.on_event(defines.events.on_built_entity, deconstructive_tile_ghost)
