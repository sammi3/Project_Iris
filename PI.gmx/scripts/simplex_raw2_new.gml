///simplex_raw2(x, y, [ARRAY 1D:INT] hash, [ARRAY 1D:1D:INT] gradient, min, max)
/*
    Calculates the simplex noise for a specified position.
    Assumes a size of 256!
    
    Argument0   -   x position
    Argument1   -   y position
    Argument2   -   Array of hash values
    Argument3   -   Corner gradients
    Argument4   -   minimum range of final value
    Argument5   -   maximum range of final value
    
    NOTE: https://code.google.com/p/battlestar-tux/source/browse/procedural/simplexnoise.cpp
 */
var __result = 0,
    //Noise contributions from the three corners:
    __n0, __n1, __n2,
    //Skew input space to determine current simplex cell
    __f2 = 0.5 * (sqrt(3.0) - 1.0);
    //Hairy factor for 2D
var __s = (argument0 + argument1) * __f2,
    __i = floor(argument0 + __s), // Treat as int
    __j = floor(argument1 + __s), // Treat as int
    __g2 = (3.0 - sqrt(3.0)) / 6.0;

var __t = (__i + __j) * __g2,
//Unskew cell origin back to x / y
    __X0 = __i - __t,
    __Y0 = __j - __t;
    
//x / y distances from the cell origin
var __x0 = argument0 - __X0,
    __y0 = argument1 - __Y0;

var __i1, __j1;
if (__x0 > __y0)
{
    __i1 = 1;
    __j1 = 0;
}
else
{
    __i1 = 0;
    __j1 = 1;
}
    
var __x1 = __x0 - __i1 + __g2,
    __y1 = __y0 - __j1 + __g2,
    __x2 = __x0 - 1.0 + 2.0 * __g2,
    __y2 = __y0 - 1.0 + 2.0 * __g2;

//Work out hashed gradient indices of the three simplex corners:
var __ii = __i % 256,
    __jj = __j % 256;
var __gi0 = argument2[@ __ii + argument2[@ __jj]] % 12,
    __gi1 = argument2[@ __ii + __i1 + argument2[@ __jj + __j1]] % 12,
    __gi2 = argument2[@ __ii + 1 + argument2[@ __jj + 1]] % 12

//Calculate contribution of ea. corner:
var __t0 = 0.5 - sqr(__x0) - sqr(__y0);
if (__t0 < 0)
    __n0 = 0;
else
{
    __t0 *= __t0;
    __n0 = sqr(__t0) * simplex_dot2(argument3[@ __gi0], __x0, __y0);
}

var __t1 = 0.5 - sqr(__x1) - sqr(__y1);
if (__t1 < 0)
    __n1 = 0;
else
{
    __t1 *= __t1;
    __n1 = sqr(__t1) * simplex_dot2(argument3[@ __gi1], __x1, __y1);
}

var __t2 = 0.5 - sqr(__x2) - sqr(__y2);
if (__t2 < 0)
    __n2 = 0.0;
else
{
    __t2 *= __t2;
    __n2 = sqr(__t2) * simplex_dot2(argument3[@ __gi2], __x2, __y2);
}

//Scale result between [-1..1]
__result = 70 * (__n0 + __n1 + __n2);
 
//Scale between whatever we like:
return __result * (argument5 - argument4) / 2 + (argument5 + argument4) / 2;




