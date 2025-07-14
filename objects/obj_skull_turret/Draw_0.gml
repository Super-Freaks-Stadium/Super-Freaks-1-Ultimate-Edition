/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _angle = lerp_360(angle_previous, angle, _frame_delta);

if (active)
	draw_sprite_ext(spr_skull_turret_on, 0, _x, _y, 1, 1, _angle, c_white, 1);
else
	draw_sprite_ext(spr_skull_turret_off, 0, _x, _y, 1, 1, _angle, c_white, 1);