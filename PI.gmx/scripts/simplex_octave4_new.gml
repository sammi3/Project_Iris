///simplex_octave4(x, y, z, w, [ARRAY 1D:INT] hash, [ARRAY 1D:1D:INT] gradient, [ARRAY 1D:1D:INT] simplex, min, max, octaves, persistance, scale)
/*
    Generates fractal simplex noise at the specified position.
    
    Argument0   -   x position
    Argument1   -   y position
    Argument2   -   z position
    Argument3   -   w position
    Argument4   -   Array of hash values
    Argument5   -   Corner gradients
    Argument6   -   Simplex reference
    Argument7   -   minimum range of final value
    Argument8   -   maximum range of final value
    Argument9   -   number of samples
    Argument10  -   delta octave intensity [0..1]
    Argument11  -   scale of deltas
    
    Returns     -   Calculated result  
 */

var __total = 0,
    __freq = argument11,
    __amp = 1,
    __maxAmp = 0; // Will keep things between [-1..1]

for (var i = 0; i < argument9; ++i)
{
    __total += simplex_raw4(argument0 * __freq, argument1 * __freq, 
                            argument2 * __freq, argument3 * __freq,
                            argument4, argument5, argument6, -1, 1) * __amp;
    
    __freq *= 2;
    __maxAmp += __amp;
    __amp *= argument10;
}

return (__total / __maxAmp) * (argument8 - argument7) / 2 + (argument8 + argument7) / 2 ;



