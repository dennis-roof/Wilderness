function generate_biomes()
    require("settings.terrain_settings")
    require("settings.biome_settings")
    require("settings.algorithms.voronoi")
    
    -- generate a random seed
	math.randomseed( os.time() )
	
	-- flush random numbers
	math.random()
	math.random()
	math.random()
	
	local site = {}
	local zone = {}
	
	local k = 0
	for k = 1, biome_settings.number_of_biomes, 1 do
	    site[k] = {}
		site[k][1] = math.random(terrain_settings.x_size)
		site[k][2] = math.random(terrain_settings.y_size)
		
		zone[k] = k
	end
	
	local zone_map = voronoi(
	    terrain_settings.y_size, 
	    terrain_settings.x_size, 
	    site, 
	    zone, 
	    biome_settings.number_of_biomes
	)
	
	local index = 1
	for y = 0, terrain_settings.y_size, 1 do
	    for x = 0, terrain_settings.x_size, 1 do
	        setZone(y, x, tonumber(zone_map:sub(index, index)) )
	        index = index + 1
	    end
	end
    
	return 0
end

