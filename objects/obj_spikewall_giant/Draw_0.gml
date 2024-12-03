/// @description 

var _frame_delta = frame_delta_level_get();
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

draw_sprite_ext(sprite_index, image_index, _x, _y, image_xscale, image_yscale, direction, c_white, 1);