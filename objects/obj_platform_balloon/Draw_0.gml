/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _height = image_yscale * sprite_get_height(sprite_index);
var _height_half = _height / 2;

draw_sprite_ext(sprite_index, 1, _x, _y, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite(spr_platform_balloon_string, 0, _x, _y + _height_half);