map_data = {}

-- The number of rows, and columns that compose the map
map_data.num_tile_cols = 32
map_data.num_tile_rows = 24

-- The tilesets definition files used.
map_data.tileset_filenames = {}
map_data.tileset_filenames[1] = "dat/tilesets/mountain_house_exterior.lua"
map_data.tileset_filenames[2] = "dat/tilesets/mountain_house_exterior2.lua"
map_data.tileset_filenames[3] = "dat/tilesets/mountain_landscape.lua"
map_data.tileset_filenames[4] = "dat/tilesets/water_tileset.lua"
map_data.tileset_filenames[5] = "dat/tilesets/village_exterior.lua"

-- The map grid to indicate walkability. 0 is walkable, 1 is not.
map_data.map_grid = {}
map_data.map_grid[0] = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 }
map_data.map_grid[1] = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1 }
map_data.map_grid[2] = { 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[3] = { 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[4] = { 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[5] = { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[6] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 }
map_data.map_grid[7] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 }
map_data.map_grid[8] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[9] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[10] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[11] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[12] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[13] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[14] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[15] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[16] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[17] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[18] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 }
map_data.map_grid[19] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[20] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[21] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[22] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[23] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[24] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[25] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[26] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[27] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[28] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[29] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[30] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[31] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[32] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[33] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[34] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[35] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[36] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[37] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[38] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[39] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[40] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[41] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
map_data.map_grid[42] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[43] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[44] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[45] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[46] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
map_data.map_grid[47] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

-- The tile layers. The numbers are indeces to the tile_mappings table.
map_data.layers = {}
map_data.layers[0] = {}
map_data.layers[0].type = "ground"
map_data.layers[0].name = "Background"
map_data.layers[0][0] = { 590, 591, 607, 606, 591, 590, 591, 590, 607, 590, 591, 606, 607, 607, 606, 590, 591, 606, 606, 606, 606, 607, 591, 591, 590, 606, 606, 607, 591, 607, 606, 590 }
map_data.layers[0][1] = { 591, 607, 590, 606, 606, 607, 606, 590, 606, 591, 606, 606, 606, 606, 591, 607, 590, 607, 606, 590, 606, 606, 591, 590, 590, 590, 606, 591, 606, 591, 607, 606 }
map_data.layers[0][2] = { 523, 623, 524, 525, 607, 590, 607, 607, 523, 524, 524, 525, 590, 591, 606, 591, 607, 591, 590, 523, 524, 525, 607, 606, 606, 607, 590, 591, 607, 591, 591, 606 }
map_data.layers[0][3] = { 622, 571, 572, 572, 572, 572, 572, 572, 572, 572, 573, 623, 525, 606, 590, 591, 590, 590, 606, 539, 540, 623, 525, 590, 590, 591, 590, 607, 590, 606, 591, 607 }
map_data.layers[0][4] = { 522, 587, 590, 590, 591, 607, 607, 606, 607, 590, 559, 573, 623, 525, 607, 606, 607, 606, 606, 555, 638, 540, 623, 525, 606, 591, 607, 606, 590, 606, 591, 591 }
map_data.layers[0][5] = { 538, 587, 606, 606, 606, 607, 607, 591, 607, 607, 527, 589, 554, 623, 606, 590, 591, 590, 606, 591, 555, 638, 540, 541, 607, 591, 590, 591, 606, 606, 607, 591 }
map_data.layers[0][6] = { 554, 587, 607, 590, 607, 606, 590, 591, 590, 607, 542, 589, 554, 538, 607, 607, 590, 606, 606, 606, 591, 555, 556, 557, 591, 590, 606, 607, 590, 606, 590, 607 }
map_data.layers[0][7] = { 554, 587, 606, 591, 590, 606, 607, 590, 591, 607, 527, 589, 522, 538, 590, 590, 590, 590, 607, 591, 607, 607, 606, 606, 606, 606, 590, 606, 606, 591, 591, 607 }
map_data.layers[0][8] = { 522, 587, 590, 591, 591, 606, 606, 607, 590, 590, 588, 589, 554, 522, 591, 607, 590, 590, 590, 590, 591, 590, 591, 591, 590, 591, 607, 607, 591, 606, 590, 606 }
map_data.layers[0][9] = { 538, 587, 542, 526, 527, 527, 542, 588, 542, 543, 526, 589, 522, 639, 606, 606, 591, 591, 606, 606, 606, 591, 606, 607, 606, 607, 590, 606, 607, 606, 607, 607 }
map_data.layers[0][10] = { 538, 587, 542, 527, 588, 543, 527, 588, 526, 526, 575, 605, 639, 557, 590, 606, 607, 591, 590, 590, 607, 606, 606, 590, 590, 591, 590, 591, 591, 590, 590, 606 }
map_data.layers[0][11] = { 638, 603, 574, 588, 588, 542, 526, 588, 575, 604, 605, 639, 557, 590, 591, 591, 606, 606, 607, 590, 606, 591, 607, 590, 591, 607, 591, 590, 591, 591, 607, 607 }
map_data.layers[0][12] = { 555, 638, 603, 574, 543, 542, 527, 575, 605, 639, 556, 557, 607, 590, 606, 591, 591, 590, 606, 591, 591, 607, 607, 590, 607, 607, 590, 607, 590, 590, 606, 591 }
map_data.layers[0][13] = { 590, 555, 638, 603, 604, 604, 604, 605, 639, 557, 606, 607, 606, 591, 606, 590, 606, 591, 590, 606, 607, 606, 590, 607, 590, 606, 607, 607, 591, 590, 606, 591 }
map_data.layers[0][14] = { 591, 591, 555, 556, 556, 556, 591, 541, 557, 591, 591, 606, 591, 607, 591, 591, 606, 591, 590, 590, 607, 591, 607, 591, 606, 606, 591, 590, 590, 606, 606, 606 }
map_data.layers[0][15] = { 606, 590, 590, 606, 590, 590, 607, 606, 590, 590, 590, 607, 591, 606, 607, 606, 607, 606, 590, 607, 607, 606, 606, 590, 606, 606, 606, 590, 606, 607, 591, 590 }
map_data.layers[0][16] = { 606, 590, 607, 591, 591, 606, 590, 606, 606, 606, 606, 607, 606, 591, 607, 606, 606, 606, 607, 606, 590, 606, 607, 591, 607, 591, 590, 607, 590, 590, 607, 591 }
map_data.layers[0][17] = { 607, 590, 591, 591, 591, 607, 562, 563, 562, 563, 562, 563, 562, 563, 562, 563, 607, 578, 590, 607, 606, 607, 607, 606, 562, 563, 562, 563, 562, 563, 562, 563 }
map_data.layers[0][18] = { 607, 591, 590, 607, 607, 607, 578, 579, 578, 579, 578, 579, 578, 579, 578, 579, 591, 594, 607, 606, 590, 591, 607, 607, 578, 579, 578, 579, 578, 579, 578, 579 }
map_data.layers[0][19] = { 607, 606, 591, 607, 591, 606, 594, 595, 594, 595, 594, 595, 594, 595, 594, 595, 607, 590, 591, 607, 591, 590, 590, 590, 594, 595, 594, 595, 594, 595, 594, 595 }
map_data.layers[0][20] = { 591, 606, 591, 607, 606, 590, 591, 591, 606, 591, 607, 591, 591, 606, 606, 591, 607, 606, 607, 591, 590, 607, 590, 606, 590, 607, 590, 606, 606, 606, 606, 590 }
map_data.layers[0][21] = { 606, 607, 607, 591, 591, 590, 606, 590, 591, 606, 606, 606, 606, 607, 590, 591, 590, 591, 607, 606, 606, 607, 591, 590, 607, 591, 607, 591, 607, 606, 591, 606 }
map_data.layers[0][22] = { 606, 591, 606, 606, 607, 607, 590, 607, 606, 606, 591, 606, 591, 591, 590, 607, 607, 606, 606, 606, 607, 607, 607, 591, 606, 590, 591, 590, 606, 607, 606, 590 }
map_data.layers[0][23] = { 591, 607, 606, 607, 607, 606, 591, 590, 590, 590, 590, 590, 591, 590, 607, 607, 591, 606, 590, 607, 606, 590, 607, 591, 606, 607, 606, 606, 606, 607, 606, 607 }

map_data.layers[1] = {}
map_data.layers[1].type = "ground"
map_data.layers[1].name = "Background 2"
map_data.layers[1][0] = { -1, -1, -1, -1, 740, 741, 742, -1, 743, 744, -1, -1, 544, 545, 546, 541, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 576, 577, 578, 579, 580 }
map_data.layers[1][1] = { -1, -1, -1, -1, 756, 757, 758, -1, 759, 760, 741, 742, 560, 561, 546, 623, 525, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 592, 593, 594, 595, 596 }
map_data.layers[1][2] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, 756, 757, 758, 544, 545, 563, 546, 541, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 608, 609, 610, 611, 612 }
map_data.layers[1][3] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 560, 577, 561, 546, 541, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][4] = { -1, -1, 33, 34, 35, 36, 37, 38, 39, 40, -1, -1, 592, 593, 561, 546, 541, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 515, 516, 517, -1, -1 }
map_data.layers[1][5] = { -1, -1, 49, 50, 51, 52, 53, 54, 55, 56, -1, -1, 608, 609, 545, 546, 541, -1, -1, -1, -1, -1, -1, -1, -1, -1, 523, 531, 532, 533, -1, -1 }
map_data.layers[1][6] = { -1, -1, 65, 66, 67, 68, 69, 70, 71, 72, -1, -1, -1, 560, 561, 546, 541, -1, -1, -1, -1, -1, -1, -1, -1, 523, 622, 547, 548, 549, -1, -1 }
map_data.layers[1][7] = { -1, -1, 81, 82, 83, 84, 85, 86, 87, 88, -1, -1, -1, 544, 545, 546, 541, -1, -1, -1, -1, 523, 524, 524, 524, 622, 562, 563, 564, 565, -1, -1 }
map_data.layers[1][8] = { -1, -1, 97, 98, 99, 100, 101, 102, 103, 104, -1, -1, -1, 560, 561, 546, 623, 524, 524, 524, 524, 622, 562, 563, 562, 563, 569, 579, 580, 581, -1, -1 }
map_data.layers[1][9] = { -1, -1, 113, 114, 115, 116, 117, 118, 119, 120, -1, -1, -1, 560, 561, 562, 563, 562, 563, 562, 563, 569, 578, 579, 578, 579, 585, 595, 596, 597, -1, -1 }
map_data.layers[1][10] = { -1, -1, 129, 130, 131, 132, 133, 134, 135, 136, -1, -1, -1, 576, 577, 578, 579, 578, 579, 578, 579, 585, 594, 595, 594, 595, 601, 611, 612, 613, -1, -1 }
map_data.layers[1][11] = { -1, -1, 145, 146, 147, 148, 149, 150, 151, 152, -1, -1, -1, 592, 593, 594, 595, 594, 595, 594, 595, 601, 610, 611, 610, 611, 617, -1, -1, -1, -1, -1 }
map_data.layers[1][12] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 608, 609, 610, 611, 610, 611, 610, 611, 617, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][13] = { -1, -1, -1, -1, -1, 513, 514, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][14] = { -1, -1, -1, -1, 528, 529, 530, 639, -1, -1, -1, -1, -1, -1, -1, -1, 523, 524, 524, 524, 524, 524, 524, 525, -1, -1, -1, -1, -1, -1, -1, 523 }
map_data.layers[1][15] = { -1, -1, -1, -1, 544, 545, 546, 623, 525, -1, -1, -1, -1, -1, -1, 523, 622, 563, 562, 563, 562, 563, 563, 623, 525, -1, -1, -1, -1, -1, -1, 539 }
map_data.layers[1][16] = { -1, -1, -1, -1, 560, 561, 562, 563, 623, 524, 524, 524, 524, 524, 524, 622, 567, 569, 578, 579, 578, 579, 566, 567, 623, 524, 524, 524, 524, 524, 524, 622 }
map_data.layers[1][17] = { -1, -1, -1, -1, 560, 561, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 706, 707, 594, 595, 594, 595, 704, 705, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][18] = { -1, -1, -1, -1, 576, 577, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 722, 723, 610, 611, 610, 611, 720, 721, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][19] = { -1, -1, -1, -1, 592, 593, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 738, 739, -1, -1, -1, -1, 736, 737, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][20] = { -1, -1, -1, -1, 608, 609, 610, 611, 610, 611, 610, 611, 610, 611, 610, 611, 754, 755, -1, -1, -1, -1, 752, 753, 610, 611, 610, 611, 610, 611, 610, 611 }
map_data.layers[1][21] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][22] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[1][23] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }

map_data.layers[2] = {}
map_data.layers[2].type = "ground"
map_data.layers[2].name = "Background 3"
map_data.layers[2][0] = { -1, -1, -1, 1094, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][1] = { 741, 742, -1, -1, -1, -1, -1, -1, -1, 740, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1084, -1, 1084, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][2] = { 757, 758, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1084, 1084, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][3] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1084, -1, -1, -1, -1, 1084, 1082, 764 }
map_data.layers[2][4] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 560, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1084, -1, -1, -1, -1, -1 }
map_data.layers[2][5] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 544, -1, -1, -1, 1094, 1094, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][6] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1094, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][7] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1094, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1081, -1 }
map_data.layers[2][8] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][9] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1043, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][10] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1027, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1081, -1 }
map_data.layers[2][11] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][12] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1081, -1, 1079, -1, -1, 1078, -1, 1081, -1, -1, -1 }
map_data.layers[2][13] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1081, 1081, 1079, -1, 1114, 1114, -1 }
map_data.layers[2][14] = { -1, 1079, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1077, -1, -1, 1114, 1114, -1, -1 }
map_data.layers[2][15] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1081, -1, 1114, -1, -1, -1, -1 }
map_data.layers[2][16] = { -1, 1084, -1, -1, -1, -1, 1044, 1043, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1081, -1, -1, -1 }
map_data.layers[2][17] = { -1, -1, -1, -1, -1, -1, 1043, 1044, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][18] = { -1, -1, -1, 1084, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][19] = { -1, 1084, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][20] = { -1, -1, -1, -1, 1084, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1077, -1, -1, 1079, 1078, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[2][21] = { -1, 1084, -1, -1, -1, -1, 1095, -1, -1, -1, -1, -1, -1, 1095, -1, -1, -1, 1077, -1, 1114, 1078, -1, 1079, -1, -1, -1, 1095, 1084, -1, 1095, -1, 1094 }
map_data.layers[2][22] = { -1, 1116, 1084, -1, -1, -1, -1, -1, -1, 1095, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1094, -1, -1, -1 }
map_data.layers[2][23] = { -1, -1, -1, -1, 1084, -1, -1, -1, 1082, -1, -1, -1, 1095, -1, -1, -1, 1084, -1, -1, -1, 1077, -1, -1, -1, 1114, 1094, -1, 1094, 1078, -1, -1, -1 }

map_data.layers[3] = {}
map_data.layers[3].type = "ground"
map_data.layers[3].name = "Static Trees"
map_data.layers[3][0] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][1] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][2] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][3] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][4] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][5] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][6] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][7] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][8] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][9] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][10] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][11] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][12] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][13] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][14] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][15] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][16] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][18] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][19] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][20] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][21] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][22] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[3][23] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }

map_data.layers[4] = {}
map_data.layers[4].type = "sky"
map_data.layers[4].name = "Sky"
map_data.layers[4][0] = { 725, 726, -1, -1, -1, -1, -1, -1, -1, 724, 725, 726, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][1] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][2] = { -1, -1, 1, 2, 3, 4, 5, 6, 7, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][3] = { -1, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][4] = { -1, 32, 33, -1, -1, -1, -1, -1, -1, 40, 41, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][5] = { -1, 48, 49, -1, -1, -1, -1, -1, -1, 56, 57, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][6] = { -1, 64, 65, -1, -1, -1, -1, -1, -1, 72, 73, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][7] = { -1, 80, 81, -1, -1, -1, -1, -1, -1, 88, 89, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][8] = { -1, 96, 97, -1, -1, -1, -1, -1, -1, 104, 105, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][9] = { -1, 112, -1, -1, -1, -1, -1, -1, -1, -1, 121, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][10] = { -1, 128, -1, -1, -1, -1, -1, -1, -1, -1, 137, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][11] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][12] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][13] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][14] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][15] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][16] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][18] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][19] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][20] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][21] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[4][22] = { 518, 519, 520, 521, 518, 519, 520, 521, 518, 519, 520, 521, 518, 519, 520, 521, 518, 519, 520, 521, 518, 519, 520, 521, 518, -1, -1, 521, 518, 519, 520, 521 }
map_data.layers[4][23] = { 534, 535, 536, 537, 534, 535, 536, 537, 534, 535, 536, 537, 534, 535, 536, 537, 534, 535, 536, 537, 534, 535, 536, 537, 513, 514, 515, 516, 534, 535, 536, 537 }

map_data.layers[5] = {}
map_data.layers[5].type = "sky"
map_data.layers[5].name = "Sky2"
map_data.layers[5][0] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][1] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][2] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][3] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][4] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][5] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][6] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][7] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][8] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][9] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][10] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][11] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][12] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][13] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][14] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][15] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][16] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][18] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][19] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][20] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][21] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][22] = { 515, 516, 517, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
map_data.layers[5][23] = { 531, 532, 533, -1, -1, -1, 513, 514, 515, 516, -1, -1, -1, -1, -1, -1, -1, -1, -1, 513, 514, 515, 516, -1, -1, -1, -1, -1, -1, -1, -1, -1 }

