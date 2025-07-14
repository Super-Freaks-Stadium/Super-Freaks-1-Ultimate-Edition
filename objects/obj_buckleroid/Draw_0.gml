/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _angle = lerp_360(angle_previous, angle, _frame_delta);

if (blink)
	gpu_set_fog(1, c_red, 0, 0);
draw_sprite_ext(sprite_index, image_index, _x, _y, 1, 1, _angle, c_white, 1);
if (blink)
	gpu_set_fog(0, c_white, 0, 0);