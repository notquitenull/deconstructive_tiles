require('general')

local function deconstruct_on_tile(surface, player, tile, cooldown, offest)
	local pos = {tile.position.x + offest, tile.position.y + offest}
	local entities = surface.find_entities_filtered{position = pos}
	for i = 1, #entities do 
		-- these must be seperate and in this order otherwise the mod cuases a nil access crash
		if entities[i].tags == nil then 										-- pre-mod tiles will always be deconstructed
			entities[i].order_deconstruction(player.force, player) 
		elseif entities[i].tags[base_name .. "built_on_tick"] + cooldown < game.tick then 	-- do not deconstruct if built in the same tick
			entities[i].order_deconstruction(player.force, player)
		end
	end
end
local function deconstruct_on_ghost(surface, player, tile, cooldown)
	deconstruct_on_tile(surface, player, tile, cooldown, 0)
end


local function deconstructive_tile_built(event) 
	if event.tile.name == base_name .. "base" then 
		local surface = game.get_surface(event.surface_index)
		local player = game.get_player(event.player_index)
		
		for i = 1, #event.tiles do 
			deconstruct_on_tile(surface, player, event.tiles[i], 0, 0.5)
		end
	elseif event.tile.name == base_name .. tile_variants.cautious or
		   event.tile.name == base_name .. tile_variants.ghost_only then
		local surface = game.get_surface(event.surface_index)
		for i = 1, #event.tiles do
			surface.set_tiles({{name=base_name .. tile_variants.basic, position = event.tiles[i].position}})
		end
	end
end

local function deconstructive_tile_ghost(event) 
	-- assign each built entity the tick it was built on, I have to override the entire dict because for some annoying reason factorio simply ignores any attempt to set an individual value
	event.created_entity.tags = {[base_name .. "built_on_tick"] = game.tick}
	if event.created_entity.name == "tile-ghost" then
		if event.created_entity.ghost_name == base_name .. tile_variants.basic or
		   event.created_entity.ghost_name == base_name .. tile_variants.cautious then
			local surface = game.get_surface(event.created_entity.surface_index)
			local player = game.get_player(event.player_index)
			
			deconstruct_on_ghost(surface, player, event.created_entity, cooldown)
		end
	end
end

script.on_event(defines.events.on_player_built_tile, deconstructive_tile_built)
script.on_event(defines.events.on_built_entity, deconstructive_tile_ghost)
