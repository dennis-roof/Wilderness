N_SITES = 9
site = {}
zone = {}

size_x = 80
size_y = 40

function sq2(x, y)
	return x * x + y * y
end

function nearest_site(x, y)
	local k = 0
	local ret = 0
	local d = 0
	local dist = 0;
	
	for k = 1, N_SITES, 1 do
		d = sq2(x - site[k][1], y - site[k][2])
		if (k == 1 or d < dist) then
			dist = d
			ret = k
		end
	end
	
	return ret
end

-- see if a pixel is different from any neighboring ones
function at_edge(color, y, x)
	local  i = color[y * size_x + x]
	local j = i
	local c = i
	
	local continue = false
	
	for i = y - 1, y + 2, 1 do
	    continue = false
		if (i < 0 or i >= size_y) then continue = true end
        
        if (not continue) then
		    for j = x - 1, x + 2, 1 do
			    if (j < 0 or j >= size_x) then continue = true end
			    
			    if (not continue) then
			        if (color[i * size_x + j] ~= c) then return 1 end
			    end
		    end
		end
    end
    
	return 0
end

function replace_char(pos, str, r)
    return table.concat{str:sub(1,pos-1), r, str:sub(pos+1)}
end

function gen_map()
	local i = 0
	local j = 0
	local k = 0
	
	local nearest = {}
	local ptr = ""
	local buf = ""
	local color = ""
	
	local continue = false
	
	for i = 1, size_y, 1 do
	    for j = 1, size_x, 1 do
	        nearest[i * size_x + j] = nearest_site(j, i)
	    end
	end
	
	for i = 1, size_y, 1 do
	    for j = 1, size_x, 1 do
			ptr = ptr .. zone[nearest[i * size_x + j]]
	    end
	end
	
	-- draw sites
	for k = 1, N_SITES, 1 do
	    color = zone[k]
	    
		for i = site[k][2] - 1, site[k][2] + 2, 1 do
			if (i < 1 or i >= size_y) then continue = true end
			
			if (not continue) then
			    for j = site[k][1] - 1, site[k][1] + 2, 1 do
				    if (j < 1 or j >= size_x) then continue = true end
				    
				    if (not continue) then
				        ptr = replace_char((i * size_x + j), ptr, color)
				    end
			    end
			end
		end
	end
	
	local index = 1
	for y = 1, size_y, 1 do
	    print(ptr:sub(index, index+size_x-1))
	    index = index + size_x
	end
end

function main()
    -- generate a random seed
	math.randomseed( os.time() )
	
	-- flush random numbers
	math.random()
	math.random()
	math.random()
	
	local k = 0
	for k = 1, N_SITES, 1 do
	    site[k] = {}
		site[k][1] = math.random(size_x)
		site[k][2] = math.random(size_y)
		
		zone[k] = k
	end
	
	gen_map()
	return 0
end

main()
