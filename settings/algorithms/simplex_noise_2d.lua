-- Simplex noise with true analytic in 2D
-- Original Copyright © 2003-2011, Stefan Gustavson
-- Contact: stefan.gustavson@gmail.com

-- This library is public domain software, released by the author
-- into the public domain in February 2011. You may do anything
-- you like with it. You may even remove all attributions,
-- but of course I'd appreciate it if you kept my name somewhere.

-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- General Public License for more details.

-- \file
-- \brief C implementation file for Perlin simplex noise with analytic in 2D
-- \author Stefan Gustavson (stefan.gustavson@gmail.com)

-- This is an implementation of Perlin "simplex noise" over two
-- dimensions (x,y). The analytic derivative is
-- returned, to make it possible to do lots of fun stuff like
-- flow animations, curl noise, analytic antialiasing and such.


-- Static data

-- Permutation table. This is just a random jumble of all numbers 0-255,
-- repeated twice to avoid wrapping the index at 255 for each lookup.

perm = {151,160,137,91,90,15,
  131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
  190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
  88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
  77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
  102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
  135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
  5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
  223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
  129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
  251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
  49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
  138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180,
  151,160,137,91,90,15,
  131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
  190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
  88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
  77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
  102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
  135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
  5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
  223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
  129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
  251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
  49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
  138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180 
}


-- Gradient tables. These could be programmed the Ken Perlin way with
-- some clever bit-twiddling, but this is more clear, and not really slower.

grad2lut = {
  { -1.0, -1.0 }, { 1.0, 0.0 } , { -1.0, 0.0 } , { 1.0, 1.0 } ,
  { -1.0, 1.0 } , { 0.0, -1.0 } , { 0.0, 1.0 } , { 1.0, -1.0 }
}


-- A lookup table to traverse the simplex around a given point in 4D.
-- Details can be found where this table is used, in the 4D noise method.
-- TODO: This should not be required, backport it from Bill's GLSL code!
simplex = {
  {0,1,2,3},{0,1,3,2},{0,0,0,0},{0,2,3,1},{0,0,0,0},{0,0,0,0},{0,0,0,0},{1,2,3,0},
  {0,2,1,3},{0,0,0,0},{0,3,1,2},{0,3,2,1},{0,0,0,0},{0,0,0,0},{0,0,0,0},{1,3,2,0},
  {0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},
  {1,2,0,3},{0,0,0,0},{1,3,0,2},{0,0,0,0},{0,0,0,0},{0,0,0,0},{2,3,0,1},{2,3,1,0},
  {1,0,2,3},{1,0,3,2},{0,0,0,0},{0,0,0,0},{0,0,0,0},{2,0,3,1},{0,0,0,0},{2,1,3,0},
  {0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},
  {2,0,1,3},{0,0,0,0},{0,0,0,0},{0,0,0,0},{3,0,1,2},{3,0,2,1},{0,0,0,0},{3,1,2,0},
  {2,1,0,3},{0,0,0,0},{0,0,0,0},{0,0,0,0},{3,1,0,2},{0,0,0,0},{3,2,0,1},{3,2,1,0}
}


-- Helper functions to compute gradients in 1D to 4D
-- and gradients-dot-residualvectors in 2D to 4D.
-- REQUIRES LUA 5.3 for bitwise operator
--function grad2( hash, gx, gy )
function grad2( hash )
    local h = (hash & 7) + 1 -- add one because lua arrays start at index 1
    
    return grad2lut[h][1], grad2lut[h][2]
end

-- Skewing factors for 2D simplex grid:
-- F2 = 0.5*(sqrt(3.0)-1.0)
-- G2 = (3.0-Math.sqrt(3.0))/6.0
F2 = 0.366025403
G2 = 0.211324865


-- 2D simplex noise with derivatives.
-- If the last two arguments are not null, the analytic derivative
-- (the 2D gradient of the scalar noise field) is also calculated.
function simplex_noise_2d( x, y, dnoise_dx, dnoise_dy )
    local n0, n1, n2 -- Noise contributions from the three simplex corners
    local gx0, gy0, gx1, gy1, gx2, gy2 -- Gradients at simplex corners

    -- Skew the input space to determine which simplex cell we're in
    local s = ( x + y ) * F2 -- Hairy factor for 2D
    local xs = x + s
    local ys = y + s
    local i = math.floor( xs )
    local j = math.floor( ys )

    local t = ( i + j ) * G2
    local X0 = i - t -- Unskew the cell origin back to (x,y) space
    local Y0 = j - t
    local x0 = x - X0 -- The x,y distances from the cell origin
    local y0 = y - Y0

    -- For the 2D case, the simplex shape is an equilateral triangle.
    -- Determine which simplex we are in.
    local i1, j1; -- Offsets for second (middle) corner of simplex in (i,j) coords
    if( x0 > y0 ) then -- lower triangle, XY order: (0,0)->(1,0)->(1,1)
        i1 = 1
        j1 = 0
    else -- upper triangle, YX order: (0,0)->(0,1)->(1,1)
        i1 = 0
        j1 = 1
    end

    -- A step of (1,0) in (i,j) means a step of (1-c,-c) in (x,y), and
    -- a step of (0,1) in (i,j) means a step of (-c,1-c) in (x,y), where
    -- c = (3-sqrt(3))/6   */
    local x1 = x0 - i1 + G2 -- Offsets for middle corner in (x,y) unskewed coords
    local y1 = y0 - j1 + G2
    local x2 = x0 - 1.0 + 2.0 * G2 -- Offsets for last corner in (x,y) unskewed coords
    local y2 = y0 - 1.0 + 2.0 * G2

    -- Wrap the integer indices at 256, to avoid indexing perm[] out of bounds
    local ii = (i & 0xff) + 1 -- add one because lua arrays start at index 1
    local jj = (j & 0xff) + 1 -- add one because lua arrays start at index 1

    -- Calculate the contribution from the three corners
    local t0 = 0.5 - x0 * x0 - y0 * y0
    local t20, t40
    if ( t0 < 0.0 ) then  -- No influence
        t40 = 0.0
        t20 = 0.0
        t0 = 0.0
        n0 = 0.0
        gx0 = 0.0
        gy0 = 0.0
    else
        gx0, gy0 = grad2( perm[ii + perm[jj]] )
        t20 = t0 * t0
        t40 = t20 * t20
        n0 = t40 * ( gx0 * x0 + gy0 * y0 )
    end

    local t1 = 0.5 - x1 * x1 - y1 * y1
    local t21, t41
    if ( t1 < 0.0 ) then  -- No influence
        t21 = 0.0
        t41 = 0.0
        t1 = 0.0
        n1 = 0.0
        gx1 = 0.0
        gy1 = 0.0
    else
      gx1, gy1 = grad2( perm[ii + i1 + perm[jj + j1]] )
      t21 = t1 * t1
      t41 = t21 * t21
      n1 = t41 * ( gx1 * x1 + gy1 * y1 )
    end

    local t2 = 0.5 - x2 * x2 - y2 * y2
    local t22, t42
    if ( t2 < 0.0 ) then  -- No influence
        t42 = 0.0
        t22 = 0.0
        t2 = 0.0
        n2 = 0.0
        gx2 = 0.0
        gy2 = 0.0
    else
      gx2, gy2 = grad2( perm[ii + 1 + perm[jj + 1]] )
      t22 = t2 * t2
      t42 = t22 * t22
      n2 = t42 * ( gx2 * x2 + gy2 * y2 )
    end

    -- Add contributions from each corner to get the final noise value.
    -- The result is scaled to return values in the interval [-1,1].
    local noise = 40.0 * ( n0 + n1 + n2 )

    -- Compute derivative, if requested by supplying non-null pointers
    -- for the last two arguments
    if ( ( dnoise_dx ~= 0 ) and ( dnoise_dy ~= 0 ) ) then
	    --  A straight, unoptimised calculation would be like:
        --    *dnoise_dx = -8.0f * t20 * t0 * x0 * ( gx0 * x0 + gy0 * y0 ) + t40 * gx0;
        --    *dnoise_dy = -8.0f * t20 * t0 * y0 * ( gx0 * x0 + gy0 * y0 ) + t40 * gy0;
        --    *dnoise_dx += -8.0f * t21 * t1 * x1 * ( gx1 * x1 + gy1 * y1 ) + t41 * gx1;
        --    *dnoise_dy += -8.0f * t21 * t1 * y1 * ( gx1 * x1 + gy1 * y1 ) + t41 * gy1;
        --    *dnoise_dx += -8.0f * t22 * t2 * x2 * ( gx2 * x2 + gy2 * y2 ) + t42 * gx2;
        --    *dnoise_dy += -8.0f * t22 * t2 * y2 * ( gx2 * x2 + gy2 * y2 ) + t42 * gy2;
        local temp0 = t20 * t0 * ( gx0* x0 + gy0 * y0 )
        dnoise_dx = temp0 * x0
        dnoise_dy = temp0 * y0
        local temp1 = t21 * t1 * ( gx1 * x1 + gy1 * y1 )
        dnoise_dx = dnoise_dx + (temp1 * x1)
        dnoise_dy = dnoise_dy + (temp1 * y1)
        local temp2 = t22 * t2 * ( gx2* x2 + gy2 * y2 )
        dnoise_dx = dnoise_dx + (temp2 * x2)
        dnoise_dy = dnoise_dy + (temp2 * y2)
        dnoise_dx = dnoise_dx * -8.0
        dnoise_dy = dnoise_dy * -8.0
        dnoise_dx = dnoise_dx + (t40 * gx0 + t41 * gx1 + t42 * gx2)
        dnoise_dy = dnoise_dy + (t40 * gy0 + t41 * gy1 + t42 * gy2)
        dnoise_dx = dnoise_dx * 40.0 -- Scale derivative to match the noise scaling
        dnoise_dy = dnoise_dy * 40.0
    end
    return noise;
end

