///simplex_raw4(x, y, z, w, [ARRAY 1D:INT] hash, [ARRAY 1D:1D:INT] gradient, [ARRAY 1D:1D:INT] simplex, min, max)
/*
    Calculates the simplex noise for a specified position.
    Assumes a size of 256!
    
    Argument0   -   x position
    Argument1   -   y position
    Argument2   -   z position
    Argument3   -   w position
    Argument4   -   Array of hash values
    Argument5   -   Corner gradients
    Argument6   -   Simplex reference
    Argument7   -   minimum range of final value
    Argument8   -   maximum range of final value
*/


//Skewing / Unskewing factors:
var F4 = (sqrt(5.0) - 1.0) / 4.0,
    G4 = (5.0 - sqrt(5.0)) / 20.0;
var n0, n1, n2, n3, n4;

//Skew 4D space to determine which cell we are in:
var s = (argument0 + argument1 + argument2 + argument3) * F4;
var i = floor(argument0 + s),
    j = floor(argument1 + s),
    k = floor(argument2 + s),
    l = floor(argument3 + s);
var t = (i + j + k + l) * G4;
var X0 = i - t,
    Y0 = j - t,
    Z0 = k - t,
    W0 = l - t;
var x0 = argument0 - X0,
    y0 = argument1 - Y0,
    z0 = argument2 - Z0,
    w0 = argument3 - W0;
    

var c1 = (x0 > y0) * 32,
    c2 = (x0 > z0) * 16,
    c3 = (y0 > z0) * 8,
    c4 = (x0 > w0) * 4,
    c5 = (y0 > w0) * 2,
    c6 = (z0 > w0);
var c = c1 + c2 + c3 + c4 + c5 + c6;

var i1, j1, k1, l1, //Second simplex corner offset
    i2, j2, k2, l2, //Third     "       "
    i3, j3, k3, l3; //Fourth    "       "

var __a = argument6[@ c];
i1 = (__a[@ 0] >= 3);
j1 = (__a[@ 1] >= 3);
k1 = (__a[@ 2] >= 3);
l1 = (__a[@ 3] >= 3);

i2 = (__a[@ 0] >= 2);
j2 = (__a[@ 1] >= 2);
k2 = (__a[@ 2] >= 2);
l2 = (__a[@ 3] >= 2);

i3 = (__a[@ 0] >= 1);
j3 = (__a[@ 1] >= 1);
k3 = (__a[@ 2] >= 1);
l3 = (__a[@ 3] >= 1);

//Corner offsets in x,y,z,w coords:
var __G42 = G4 *2,
    __G43 = G4 *4;
var x1 = x0 - i1 + G4,
    y1 = y0 - j1 + G4,
    z1 = z0 - k1 + G4,
    w1 = w0 - l1 + G4,
    
    x2 = x0 - i2 + __G42,
    y2 = y0 - j2 + __G42,
    z2 = z0 - k2 + __G42,
    w2 = w0 - l2 + __G42,
    
    x3 = x0 - i3 + G4 * 3.0,
    y3 = y0 - j3 + G4 * 3.0,
    z3 = z0 - k3 + G4 * 3.0,
    w3 = w0 - l3 + G4 * 3.0,
    
    x4 = x0 - 1.0 + __G43,
    y4 = y0 - 1.0 + __G43,
    z4 = z0 - 1.0 + __G43,
    w4 = w0 - 1.0 + __G43;
//Hashed gradient indices:
var ii = i % 256,
    jj = j % 256,
    kk = k % 256,
    ll = l % 256;
    
var gi0 = argument4[@ ii + argument4[@ jj + argument4[@ kk + argument4[@ ll]]]] & 31,
    gi1 = argument4[@ ii + i1 + argument4[@ jj + j1 + argument4[@ kk + k1 + argument4[@ ll + l1]]]] & 31,
    gi2 = argument4[@ ii + i2 + argument4[@ jj + j2 + argument4[@ kk + k2 + argument4[@ ll + l2]]]] & 31,
    gi3 = argument4[@ ii + i3 + argument4[@ jj + j3 + argument4[@ kk + k3 + argument4[@ ll + l3]]]] & 31,
    gi4 = argument4[@ ii + 1.0 + argument4[@ jj + 1.0 + argument4[@ kk + 1.0 + argument4[@ ll + 1.0]]]] & 31;

//Calculate contribution for ea. corner:

t0 = 0.6 - sqr(x0) - sqr(y0) - sqr(z0) - sqr(w0);

if (t0 < 0)
    n0 = 0.0;
else
{
    t0 *= t0;
    n0 = sqr(t0) * simplex_dot4(argument5[@ gi0], x0, y0, z0, w0);
}

var t1 = 0.6 - sqr(x1) - sqr(y1) - sqr(z1) - sqr(w1);
if (t1 < 0)
    n1 = 0.0;
else
{
    t1*= t1;
    n1 = sqr(t1) * simplex_dot4(argument5[@ gi1], x1, y1, z1, w1);
}

var t2 = 0.6 - sqr(x2) - sqr(y2) - sqr(z2) - sqr(w2);
if (t2 < 0)
    n2 = 0.0;
else
{
    t2 *= t2;
    n2 = sqr(t2) * simplex_dot4(argument5[@ gi2], x2, y2, z2, w2);
}

var t3 = 0.6 - sqr(x3) - sqr(y3) - sqr(z3) - sqr(w3);
if (t3 < 0)
    n3 = 0.0;
else
{
    t3 *= t3;
    n3 = sqr(t3) * simplex_dot4(argument5[@ gi3], x3, y3, z3, w3);
}

var t4 = 0.6 - sqr(x4) - sqr(y4) - sqr(z4) - sqr(w4);
if (t4 < 0)
    n4 = 0.0;
else
{
    t4 *= t4;
    n4 = sqr(t4) * simplex_dot4(argument5[@ gi4], x4, y4, z4, w4);
}
    

return (27.0 * (n0 + n1 + n2 + n3 + n4)) * (argument8 - argument7) / 2 + (argument8 + argument7) / 2;
