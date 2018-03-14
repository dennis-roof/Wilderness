# Wilderness
Generating configurable wilderness

This project requires Lua 5.3. In Ubuntu:
apt-get install liblua5.3-dev

Compiled with GCC:
gcc -o generate_world generate_world.c -I/usr/include -llua5.3

Or run the compile sh script with Lua 5.3 and GCC installed:
./compile

To generate the world, run this in the terminal:
./generate_world

To configure the world generator, edit settings/terrain_settings.lua
