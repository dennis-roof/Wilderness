#include <stdio.h>
#include <stdlib.h>

#include <lua5.3/lua.h>
#include <lua5.3/lauxlib.h>
#include <lua5.3/lualib.h> 


#define C_NORMAL	"\x1B[0m"

#define C_RED		"\x1B[31m"
#define C_GREEN		"\x1B[32m"
#define C_YELLOW	"\x1B[33m"
#define C_BLUE		"\x1B[34m"
#define C_MAGENTA	"\x1B[35m"
#define C_CYAN		"\x1B[36m"
#define C_WHITE		"\x1B[37m"

#define C_L_RED		"\x1B[91m"
#define C_L_GREEN	"\x1B[92m"
#define C_L_YELLOW	"\x1B[93m"
#define C_L_BLUE	"\x1B[94m"
#define C_L_MAGENTA	"\x1B[95m"
#define C_L_CYAN	"\x1B[96m"
#define C_L_WHITE	"\x1B[97m"


int *drawMap(int value)
{
	if (value >= 256/8*7) { printf("%s*", C_L_WHITE); return 0; }
	if (value >= 256/8*6) { printf("%s^", C_WHITE); return 0; }
	if (value >= 256/8*5) { printf("%sT", C_GREEN); return 0; }
	if (value >= 256/8*4) { printf("%s,", C_L_GREEN); return 0; }
	if (value >= 256/8*3) { printf("%s.", C_L_YELLOW); return 0; }
	if (value >= 256/8*1) { printf("%s~", C_L_BLUE); return 0; }
	
	printf("%s~", C_BLUE);
	return 0;
}

int map[1024][1024];
int zone[1024][1024];

static int setMap(lua_State *L) {
    int y = lua_tonumber(L, -3);
    int x = lua_tonumber(L, -2);
    int value = lua_tonumber(L, -1);
    map[y][x] = value;
    
    return 1;
}

static int setZone(lua_State *L) {
    int y = lua_tonumber(L, -3);
    int x = lua_tonumber(L, -2);
    int value = lua_tonumber(L, -1);
    zone[y][x] = value;
    
    //printf("setZone(%d, %d, %d)\n", y, x, value);
    
    return 1;
}

void bail(lua_State *L, char *msg){
	fprintf(stderr, "\nFATAL ERROR:\n  %s: %s\n\n",
		msg, lua_tostring(L, -1));
	exit(1);
}

lua_State *loadLuaFunction(char* filename, char* function_name)
{
	int number_of_arguments = 0;
	int number_of_returns = 0;
	int error_function_index = 0;
	
	// Create a Lua state variable
	lua_State *L;
	L = luaL_newstate();
	
	// Load Lua libraries
	luaL_openlibs(L);
	
	// Register C functions
	lua_register(L, "setMap", setMap);
	lua_register(L, "setZone", setZone);
	
	// Load but don't run the Lua script file
	if (luaL_loadfile(L, filename))
		bail(L, "luaL_loadfile() failed");
	
	// Priming run of the loaded Lua script to create the script's global variables
	if (lua_pcall(L, number_of_arguments, number_of_returns, error_function_index))
		bail(L, "lua_pcall() failed");
	
	// Pass all arguments to the Lua script on the stack
	lua_getglobal(L, function_name);
	
	return L;
}

int main()
{
	int x = 1;
	int y = 1;
	
	// generate Lua terrain
	lua_State *L = loadLuaFunction("settings/generators/generate_terrain.lua", "generate_terrain");
	
	// Run the loaded Lua script
	if (lua_pcall(L, 0, 2, 0))
		bail(L, "lua_pcall() failed");
	
	// Retrieve the return from the Lua script
	int x_size = lua_tonumber(L, -1);
	int y_size = lua_tonumber(L, -2);
	
	lua_close(L);
	
	// generate Lua zones
	lua_State *L2 = loadLuaFunction("settings/generators/generate_biomes.lua", "generate_biomes");
	
	// Run the loaded Lua script
	if (lua_pcall(L2, 0, 0, 0))
		bail(L, "lua_pcall() failed");
	
	lua_close(L2);

	lua_State *L3 = loadLuaFunction("settings/generators/generate_ascii.lua", "generate_ascii");
	
	for (int y=0; y<y_size; y++) {
		for (int x=0; x<x_size; x++) {
			//drawMap((int) map[y][x]);
            lua_pushvalue(L3, 1);			
            
            //printf("zone: %d\n", zone[y][x]);
			
			lua_pushinteger(L3, (int) map[y][x]);
			lua_pushinteger(L3, (int) zone[y][x]);
			
		    //printf("!\n");
	        if (lua_pcall(L3, 2, 1, 0))
		        bail(L3, "lua_pcall() failed 33");
		    //printf("!!\n");
		    
	        const char *tile = lua_tostring(L3, -1);
	        lua_pop(L3, 1);
		    
		    printf("%s", tile);
		}
		printf("\n");
	}

	lua_close(L3);
	
	printf("%slua map drawn!\n", C_NORMAL);
	
	return 0;
}

