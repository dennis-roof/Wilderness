require("settings.color_settings")

biome_settings = {
    -- number of biome zones, maximum of 9
    number_of_biomes = 6,
    
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
                color = color_settings.silver,
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
            -- desert tree
            {
                encounter_percentage = 15,
                minimum_height_value = 256/16*15,
                color = color_settings.green,
                character = "T"
            },
            
            -- high sand
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*4,
                color = color_settings.yellow,
                character = "~"
            },
            
            -- sand
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*3,
                color = color_settings.orange,
                character = "~"
            },
            
            -- stone
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*2,
                color = color_settings.silver,
                character = "."
            },
            
            -- grass
            {
                encounter_percentage = 50,
                minimum_height_value = 256/16*1,
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
            -- dead tree
            {
                encounter_percentage = 15,
                minimum_height_value = 256/16*12,
                color = color_settings.orange,
                character = "T"
            },
            
            -- grass
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*10,
                color = color_settings.green,
                character = ","
            },
            
            -- wet grass
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*7,
                color = color_settings.cyan,
                character = ":"
            },
            
            -- mud
            {
                encounter_percentage = 50,
                minimum_height_value = 256/16*5,
                color = color_settings.orange,
                character = ":"
            },
            
            -- shallow water
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*4,
                color = color_settings.light_blue,
                character = "~"
            },
            
            -- deep water
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.blue,
                character = "~"
            },
        },
        
        -- biome 4 = vulcano
        {
            -- mountain
            {
                encounter_percentage = 60,
                minimum_height_value = 256/8*7,
                color = color_settings.silver,
                character = "^"
            },
            
            -- dark stone
            {
                encounter_percentage = 50,
                minimum_height_value = 256/8*5,
                color = color_settings.grey,
                character = "."
            },
            
            -- orange stone
            {
                encounter_percentage = 100,
                minimum_height_value = 256/8*4,
                color = color_settings.orange,
                character = "."
            },
            
            -- shallow lava
            {
                encounter_percentage = 75,
                minimum_height_value = 256/8*3,
                color = color_settings.light_red,
                character = "~"
            },
            
            -- hot lava
            {
                encounter_percentage = 15,
                minimum_height_value = 256/8*1,
                color = color_settings.yellow,
                character = "~"
            },
            
            -- deep lava
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.red,
                character = "~"
            }
        },
        
        -- biome 5 = ice
        {
            -- ice
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*12,
                color = color_settings.white,
                character = ":"
            },
            
            -- soft ice
            {
                encounter_percentage = 50,
                minimum_height_value = 256/16*10,
                color = color_settings.white,
                character = ";"
            },
            
            -- melting ice
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*8,
                color = color_settings.light_cyan,
                character = ";"
            },
            
            -- melted ice
            {
                encounter_percentage = 75,
                minimum_height_value = 256/16*6,
                color = color_settings.cyan,
                character = ","
            },
            
            -- floating ice
            --[[{
                encounter_percentage = 25,
                minimum_height_value = 256/16*4,
                color = color_settings.white,
                character = "-"
            },--]]
            
            -- floating melting ice
            {
                encounter_percentage = 45,
                minimum_height_value = 256/16*4,
                color = color_settings.light_blue,
                character = "-"
            },
            
            -- sea
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.blue,
                character = "~"
            }
        },
        
        -- biome 6 = tundra
        {
            -- ice
            {
                encounter_percentage = 50,
                minimum_height_value = 256/16*13,
                color = color_settings.white,
                character = "*"
            },
            
            -- blue mountains
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*12,
                color = color_settings.light_cyan,
                character = "^"
            },
            
            -- red grass
            {
                encounter_percentage = 45,
                minimum_height_value = 256/16*7,
                color = color_settings.light_red,
                character = ","
            },
            
            -- yellow grass
            {
                encounter_percentage = 45,
                minimum_height_value = 256/16*3,
                color = color_settings.yellow,
                character = ","
            },
            
            -- green grass
            {
                encounter_percentage = 100,
                minimum_height_value = 256/16*2,
                color = color_settings.green,
                character = ","
            },
            
            -- river
            {
                encounter_percentage = 100,
                minimum_height_value = 0,
                color = color_settings.light_blue,
                character = "~"
            }
        }
        
    }
}

