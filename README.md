# Wilderness
Generating configurable wilderness

## Requirements
This project requires GCC and Lua 5.3. To install the dev libraries in Ubuntu, run this in the terminal:
>apt-get install liblua5.3-dev

## Compiling with GCC
To compile the code, run this in the terminal:
>gcc -o generate_world generate_world.c -I/usr/include -llua5.3

Or run the compile sh script:
>./compile.sh

## Running the world generator
To generate the world, run this in the terminal:
>./generate_world

## Configure the world generator
To configure the world generator, edit **settings/terrain_settings.lua**

These settings are used in run-time. There is no need to recompile the code to experiment with different configuration settings.
