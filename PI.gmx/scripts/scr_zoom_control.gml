var _mouse_x,_mouse_y;
_mouse_x=(mouse_x-view_xview[1])/view_wview[1];
_mouse_y=(mouse_y-view_yview[1])/view_hview[1];

//Step 2: Update view widths and height.
view_wview[1]=base_width/zoom;
view_hview[1]=base_height/zoom;

//Step 3: Update position of view based on ratio and mouse position.
view_xview[1]=mouse_x-view_wview[1]*_mouse_x;
view_yview[1]=mouse_y-view_hview[1]*_mouse_y;

