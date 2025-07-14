/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

draw_sprite_ext(sprite_index, image_index, _x, _y, 2, 2, 0, c_white, 1);