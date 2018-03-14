float fractal_brownian_motion(int num_iterations, int x, int y, float persistence, float scale, int low, int high)
{
	float maxAmp = 0;
	float amp = 1;
	float freq = scale;
	float noise = 0;
	
	for (int i=0; i<num_iterations; i++) {
		noise += sdnoise2(x*freq, y*freq, 0, 0) * amp;
		maxAmp += amp;
		amp *= persistence;
		freq *= 2;
	}
	noise /= amp;
	
	noise = noise * (high - low) / 2 + (high + low) / 2;
	
	return noise;
}
