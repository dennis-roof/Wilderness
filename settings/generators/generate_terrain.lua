function generate_terrain()
    require("settings.terrain_settings");
    require("settings.algorithms.fractal_brownian_motion");
    
    -- generate a random seed
	math.randomseed( os.time() )
	
	-- random x and y offset, required to randomize simplex noise height maps
	local x_offset = math.random(255)
	local y_offset = math.random(255)
	
	-- generate each coordinate of the height map
	for y=0, terrain_settings.y_size, 1 do
		for x=0, terrain_settings.x_size, 1 do
			setMap( y, x, 
			    math.floor(
			        fractal_brownian_motion(
			            terrain_settings.cycles, -- number of fractal brownian motion cycles
			            x+x_offset, -- random x offset for 2d simplex noise map
			            y+y_offset, -- random y offset for 2d simplex noise map
			            terrain_settings.persistence, -- ???
			            terrain_settings.scale, -- scale of the world
			            0, -- minimum value for lowest map height
			            255 -- maximum value for highest map height
			        )
			    )
		    );
		end
	end
	
	return terrain_settings.y_size, terrain_settings.x_size
end

