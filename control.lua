require('general')
local function deconstructive_tile_built(event) 
	if event.tile.name == base_name .. "base" then 
		local surface = game.get_surface(event.surface_index)
		local player = game.get_player(event.player_index)
		
		for i = 1, #event.tiles do 
			local pos = {event.tiles[i].position.x + 0.5, event.tiles[i].position.y + 0.5}
			local entities = surface.find_entities_filtered{position = pos}
			for j = 1, #entities do 
				entities[j].order_deconstruction(player.force, player)
			end
		end
	end
end

local function deconstructive_tile_ghost(event) 
	if event.created_entity.name == "tile-ghost" then
		if event.created_entity.ghost_name == base_name .. "base" then 
			local surface = game.get_surface(event.created_entity.surface_index)
			local player = game.get_player(event.player_index)
			
			local pos = {event.created_entity.position.x, event.created_entity.position.y}
			local area = {{pos[1] - 0.5, pos[2] - 0.5}, {pos[1] + 0.5, pos[2] + 0.5}}
			game.print(area[1][1] .. area[1][2] .. area[2][1] .. area[2][2])
			local entities = surface.find_entities_filtered{position = pos}
			for j = 1, #entities do 
				entities[j].order_deconstruction(player.force, player)
			end
		end
	end
end

script.on_event(defines.events.on_player_built_tile, deconstructive_tile_built)
script.on_event(defines.events.on_built_entity, deconstructive_tile_ghost)
