--N_SITES = 9
--site = {}
--zone = {}

--size_x = 80
--size_y = 40

function sq2(x, y)
	return x * x + y * y
end

function nearest_site(x, y, site, zones)
	local k = 0
	local ret = 0
	local d = 0
	local dist = 0;
	
	for k = 1, zones, 1 do
		d = sq2(x - site[k][1], y - site[k][2])
		if (k == 1 or d < dist) then
			dist = d
			ret = k
		end
	end
	
	return ret
end

function replace_char(pos, str, r)
    return table.concat{str:sub(1,pos-1), r, str:sub(pos+1)}
end

function voronoi(size_y, size_x, site, zone, zones)
	local i = 0
	local j = 0
	local k = 0
	
	local nearest = {}
	local ptr = ""
	local color = ""
	
	local continue = false
	
	for i = 1, size_y+1, 1 do
	    for j = 1, size_x+1, 1 do
	        nearest[i * size_x + j] = nearest_site(j, i, site, zones)
	    end
	end
	
	for i = 1, size_y+1, 1 do
	    for j = 1, size_x+1, 1 do
			ptr = ptr .. zone[nearest[i * size_x + j]]
	    end
	end
	
	-- draw sites
	for k = 1, zones, 1 do
	    color = zone[k]
	    
		for i = site[k][2] - 1, site[k][2] + 2, 1 do
			if (i < 1 or i >= size_y+1) then continue = true end
			
			if (not continue) then
			    for j = site[k][1] - 1, site[k][1] + 2, 1 do
				    if (j < 1 or j >= size_x+1) then continue = true end
				    
				    if (not continue) then
				        ptr = replace_char((i * size_x+1 + j), ptr, color)
				    end
			    end
			end
		end
	end
	
	return ptr
end

