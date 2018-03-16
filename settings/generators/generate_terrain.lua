function generate_terrain()
    require("settings.terrain_settings")
    require("settings.algorithms.fractal_brownian_motion")
    require("settings.algorithms.simplex_noise_2d")
	
	-- generate each coordinate of the height map
	for y=0, terrain_settings.y_size, 1 do
		for x=0, terrain_settings.x_size, 1 do
			setMap( y, x, 
			    math.floor(
			        fractal_brownian_motion(
			            terrain_settings.cycles, -- number of fractal brownian motion cycles
			            x, -- random x offset for 2d simplex noise map
			            y, -- random y offset for 2d simplex noise map
			            terrain_settings.persistence, -- ???
			            terrain_settings.scale, -- scale of the world
			            0, -- minimum value for lowest map height
			            255, -- maximum value for highest map height
			            simplex_noise_2d -- noise function for fractal brownian motion
			        )
			    )
		    );
		end
	end
	
	return terrain_settings.y_size, terrain_settings.x_size
end

