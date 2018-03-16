require("settings.color_settings")

biome_settings = {
    -- number of biome zones, maximum of 9
    number_of_biomes = 4,
    
    -- biomes
    biomes = {
        -- biome 1 = forest
        {
            -- snow
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*7,
                color = color_settings.white,
                character = "*"
            },
            
            -- mountain
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*6,
                color = color_settings.grey,
                character = "^"
            },
            
            -- forest
            {
                encounter_percentage = 50,
                minimum_height_value = 256/8*5,
                color = color_settings.green,
                character = "T"
            },
            
            -- grass
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*4,
                color = color_settings.light_green,
                character = ","
            },
            
            -- sand
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*3,
                color = color_settings.yellow,
                character = "."
            },
            
            -- shallow water
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*1,
                color = color_settings.light_blue,
                character = "~"
            },
            
            -- deep water
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.blue,
                character = "~"
            }
        },
        
        -- biome 2 = desert
        {
            -- high sand
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*4,
                color = color_settings.yellow,
                character = "~"
            },
            
            -- sand
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*3,
                color = color_settings.orange,
                character = "~"
            },
            
            -- stone
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*2,
                color = color_settings.grey,
                character = "."
            },
            
            -- grass
            {
                encounter_percentage = 50,
                minimum_height_value = 256/8*1,
                color = color_settings.green,
                character = ","
            },
            
            -- shallow water
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.light_blue,
                character = "~"
            }
        },
        
        -- biome 3 = swamp
        {
            -- plant
            {
                encounter_percentage = 25,
                minimum_height_value = 256/8*7,
                color = color_settings.magenta,
                character = "v"
            },
            
            -- grass
            {
                encounter_percentage = 35,
                minimum_height_value = 256/8*4,
                color = color_settings.green,
                character = ","
            },
            
            -- shallow water
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*3,
                color = color_settings.cyan,
                character = "~"
            },
            
            -- deep water
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*1,
                color = color_settings.blue,
                character = "~"
            },
            
            -- shallow water
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.cyan,
                character = "~"
            }
        },
        
        -- biome 4 = vulcano
        {
            -- mountain
            {
                encounter_percentage = 60,
                minimum_height_value = 256/8*7,
                color = color_settings.grey,
                character = "^"
            },
            
            -- stone
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*5,
                color = color_settings.grey,
                character = "."
            },
            
            -- shallow lava
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*3,
                color = color_settings.light_red,
                character = "~"
            },
            
            -- deep lava
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.red,
                character = "~"
            }
        }
        
    }
}

