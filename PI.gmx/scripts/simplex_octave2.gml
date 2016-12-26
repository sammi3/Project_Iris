///simplex_octave2(x, y, [ARRAY 1D:INT] hash, [ARRAY 1D:1D:INT] gradient, min, max, octaves, persistance, scale)
/*
    Generates fractal simplex noise at the specified position.
    
    Argument0   -   x position
    Argument1   -   y position
    Argument2   -   Array of hash values
    Argument3   -   Corner gradients
    Argument4   -   minimum range of final value
    Argument5   -   maximum range of final value
    Argument6   -   number of samples
    Argument7   -   delta octave intensity [0..1]
    Argument8   -   scale of deltas
    
    Returns     -   Calculated result 
    
    NOTE: https://code.google.com/p/battlestar-tux/source/browse/procedural/simplexnoise.cpp
          https://code.google.com/p/battlestar-tux/source/browse/procedural/simplexnoise.h
          http://www.6by9.net/simplex-noise-for-c-and-python/
    
 */

var __total = 0,
    __freq = argument8,
    __amp = 1,
    __maxAmp = 0; // Will keep things between [-1..1]

for (var i = 0; i < argument6; ++i)
{
    __total += simplex_raw2(argument0 * __freq, argument1 * __freq, argument2, argument3, -1, 1) * __amp;
    
    __freq *= 2;
    __maxAmp += __amp;
    __amp *= argument7;
}

return (__total / __maxAmp) * (argument5 - argument4) / 2 + (argument5 + argument4) / 2 ;
