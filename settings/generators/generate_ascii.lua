function generate_ascii(height_value, zone)
    require("settings.biome_settings")
    
	--zone = 6 -- for testing individual biomes
    
    for key, biome in pairs(biome_settings.biomes[zone]) do
        --print(key, height_value, biome.minimum_height_value)
        if (
            height_value >= biome.minimum_height_value 
            and (
                biome.encounter_percentage > math.random(100)
                or biome.minimum_height_value == 0
            )
        ) then
            return biome.color .. biome.character
        end
    end
end

