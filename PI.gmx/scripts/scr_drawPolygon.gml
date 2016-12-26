///scr_draw_polygon(x,y,r,n,angle offset,outline)
// argument0 = x
// argument1 = y
// argument2 = r
// argument3 = n
// argument4 = angle offset
// argument5 = outline

if(argument5 = true) {
draw_primitive_begin(pr_linestrip);
}
else {
draw_primitive_begin(pr_trianglefan);
draw_vertex(argument0,argument1);
}

for(i = 0; i <= argument3; i += 1) {
draw_vertex(argument0 + lengthdir_x(argument2,i / argument3 * 360 + argument4),
argument1 + lengthdir_y(argument2,i / argument3 * 360 + argument4));
}

draw_primitive_end();
