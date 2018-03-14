function fractal_brownian_motion(num_iterations, x, y, persistence, scale, low, high)
    require("settings.algorithms.simplex_noise_2d");
    
	local maxAmp = 0
	local amp = 1
	local freq = scale
	local noise = 0
	
	for i=0, num_iterations, 1 do
		noise = noise + (simplex_noise_2d(x*freq, y*freq, 0, 0) * amp)
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

