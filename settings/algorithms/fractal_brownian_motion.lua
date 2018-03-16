function fractal_brownian_motion(num_iterations, x, y, persistence, scale, low, high, noise_function)
    -- generate a random seed
	math.randomseed( os.time() )
	
	-- flush random numbers
	math.random()
	math.random()
	math.random()
	
	-- random x and y offset, required to randomize simplex noise height maps
	local x_offset = math.random(255)
	local y_offset = math.random(255)
    
	local maxAmp = 0
	local amp = 1
	local freq = scale
	local noise = 0
	
	for i=0, num_iterations, 1 do
		noise = noise + (noise_function((x+x_offset)*freq, (y+y_offset)*freq, 0, 0) * amp)
		maxAmp = maxAmp + amp
		amp = amp * persistence
		freq = freq * 2
	end
	noise = noise / amp
	
	noise = noise * (high - low) / 2 + (high + low) / 2
	
	if (noise > high) then return high end
	if (noise < low) then return low end
	return noise
end

