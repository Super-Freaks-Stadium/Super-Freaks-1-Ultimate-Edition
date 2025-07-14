/// @description 

var _animate = lerp_360(animate_previous, animate, global.delta);
var _star_angle = lengthdir_x(22.5, _animate);

draw_sprite_interpolated(sprite_index, image_index, x, y,,,,,,, _star_angle, _star_angle,,, global.delta);