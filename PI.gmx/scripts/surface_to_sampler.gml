#define surface_to_sampler
///surface_to_sampler(ind)
//Get a sampler from a surface.
var sampler,w,h,tbuff;
sampler=ds_map_create()
w = surface_get_width(argument0)
h = surface_get_height(argument0)
ds_map_add(sampler,"width",w)
ds_map_add(sampler,"height",h)
tbuff=buffer_create(w * h * 4,buffer_fixed,4)
buffer_get_surface(tbuff,argument0,0,0,0)
ds_map_add(sampler,"data",tbuff)
global.last = -1
global.lastw = -1
global.lastb = -1

return sampler;


#define sampler_destroy
///sampler_destroy(ind)
//Destroy sampler.
buffer_delete(ds_map_find_value(argument0,"data"))
ds_map_destroy(argument0)


#define sampler_sample
///sampler_sample(ind,x,y)
//Sample a pixel in a sampler for an ABGR color.
var w,ind,buf;
if argument0 = global.last {
    w = global.lastw
    buf = global.lastb
}
else {
    w = ds_map_find_value(argument0,"width")
    buf = ds_map_find_value(argument0,"data")
    global.last = argument0
    global.lastw = w
    global.lastb = buf
}
ind = (argument2 * w + argument1) * 4
return buffer_peek(buf,ind,buffer_u32)


#define sampler_get_width
///sampler_get_width(ind)
//Get the width of a sampler.
return ds_map_find_value(argument0,"width")


#define sampler_get_height
///sampler_get_height(ind)
//Get the height of a sampler.
return ds_map_find_value(argument0,"height")


#define sampler_compare
///sampler_compare(sampler1,sampler2,precision)
//Compare the differences in color between two samplers, from 0 to 1, with 0 being the exact same and 1 being the most different possible.
//Higher precision means much less samples and quality, but more speed. Minimum 1. Recommended 1 or 2 unless the samplers are quite big.
var w,h,hi,vi,sampler1,sampler2,xx,yy,diff,num,abgr1,abgr2,a1,a2,col1,col2;
w=min(sampler_get_width(argument0),sampler_get_width(argument1))
h=min(sampler_get_height(argument0),sampler_get_height(argument1))
hi=floor(w/argument2)
vi=floor(h/argument2)
sampler1=argument0
sampler2=argument1

diff=0
num=vi*hi
yy=0
repeat vi {
    xx=0
    repeat hi {
        abgr1=sampler_sample(sampler1,floor(xx),floor(yy))
        abgr2=sampler_sample(sampler2,floor(xx),floor(yy))
        a1=abgr_get_a(abgr1)
        a2=abgr_get_a(abgr2)
        col1=abgr_get_rgb(abgr1)
        col2=abgr_get_rgb(abgr2)
        diff+=(abs(color_get_red(col1)-color_get_red(col2))/255+abs(color_get_green(col1)-color_get_green(col2))/255+abs(color_get_blue(col1)-color_get_blue(col2))/255+abs(a1-a2)/255)/4
        xx+=argument2
    }
    yy+=argument2
}

return diff/num;


#define sampler_compare_red
///sampler_compare_red(sampler1,sampler2,precision)
//Compare the differences in the red color channel between two samplers, from 0 to 1, with 0 being the exact same and 1 being the most different possible.
//Higher precision means much less samples and quality, but more speed. Minimum 1. Recommended 1 or 2 unless the samplers are quite big.
var w,h,hi,vi,sampler1,sampler2,xx,yy,diff,num,col1,col2;
w=min(sampler_get_width(argument0),sampler_get_width(argument1))
h=min(sampler_get_height(argument0),sampler_get_height(argument1))
hi=floor(w/argument2)
vi=floor(h/argument2)
sampler1=argument0
sampler2=argument1

diff=0
num=vi*hi
yy=0
repeat vi {
    xx=0
    repeat hi {
        col1=abgr_get_rgb(sampler_sample(sampler1,floor(xx),floor(yy)))
        col2=abgr_get_rgb(sampler_sample(sampler2,floor(xx),floor(yy)))
        diff+=abs(color_get_red(col1)-color_get_red(col2))/255
        xx+=argument2
    }
    yy+=argument2
}

return diff/num;


#define sampler_compare_green
///sampler_compare_green(sampler1,sampler2,precision)
//Compare the differences in the green color channel between two samplers, from 0 to 1, with 0 being the exact same and 1 being the most different possible.
//Higher precision means much less samples and quality, but more speed. Minimum 1. Recommended 1 or 2 unless the samplers are quite big.
var w,h,hi,vi,sampler1,sampler2,xx,yy,diff,num,col1,col2;
w=min(sampler_get_width(argument0),sampler_get_width(argument1))
h=min(sampler_get_height(argument0),sampler_get_height(argument1))
hi=floor(w/argument2)
vi=floor(h/argument2)
sampler1=argument0
sampler2=argument1

diff=0
num=vi*hi
yy=0
repeat vi {
    xx=0
    repeat hi {
        col1=abgr_get_rgb(sampler_sample(sampler1,floor(xx),floor(yy)))
        col2=abgr_get_rgb(sampler_sample(sampler2,floor(xx),floor(yy)))
        diff+=abs(color_get_green(col1)-color_get_green(col2))/255
        xx+=argument2
    }
    yy+=argument2
}

return diff/num;


#define sampler_compare_blue
///sampler_compare_blue(sampler1,sampler2,precision)
//Compare the differences in the blue color channel between two samplers, from 0 to 1, with 0 being the exact same and 1 being the most different possible.
//Higher precision means much less samples and quality, but more speed. Minimum 1. Recommended 1 or 2 unless the samplers are quite big.
var w,h,hi,vi,sampler1,sampler2,xx,yy,diff,num,col1,col2;
w=min(sampler_get_width(argument0),sampler_get_width(argument1))
h=min(sampler_get_height(argument0),sampler_get_height(argument1))
hi=floor(w/argument2)
vi=floor(h/argument2)
sampler1=argument0
sampler2=argument1

diff=0
num=vi*hi
yy=0
repeat vi {
    xx=0
    repeat hi {
        col1=abgr_get_rgb(sampler_sample(sampler1,floor(xx),floor(yy)))
        col2=abgr_get_rgb(sampler_sample(sampler2,floor(xx),floor(yy)))
        diff+=abs(color_get_blue(col1)-color_get_blue(col2))/255
        xx+=argument2
    }
    yy+=argument2
}

return diff/num;


#define abgr_get_rgb
///abgr_get_rgb(color)
//Convert an ARGB format color to RGB.
var col = argument0 & 16777215
return make_colour_rgb(color_get_blue(col),color_get_green(col),color_get_red(col));


#define abgr_get_a
///abgr_get_a(color)
//Get the alpha channel of an ABGR color.
return (argument0 >> 24) & 255;