# Wilderness
Generating configurable wilderness.

## How does it work
Using a multiple iterated Simplex Noise algorithm, a 2D height map with number values is generated. The numbers range from low ground 0 to high ground 255.

Also a voronoi diagram is generated to create multiple zones on the map. Each zone will have its own ruleset on how to interpret the height map values within that zone.

Each zone will convert values beneath a threshold as water, values above a threshold as mountains and everything in between as vegetation.

## Example wilderness
ASCII symbols and colors represent the wilderness. Like water (~), ground (. and ,), mountains (^) and snow (*).

[alt text](https://github.com/dennis-roof/Wilderness/raw/master/example.jpg)

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
All settings configuration files are located in the **settings** directory.

The **color settings** set the different colors for linux terminals.

The **terrain settings** set the values to generate a height map for the wilderness.

The **biome settings** set the different rulesets on how to interpret the height map values for each voronoi zone on the map.

These settings are used in run-time. There is no need to recompile the code to experiment with different configuration settings.
