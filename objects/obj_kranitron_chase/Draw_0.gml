/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

draw_sprite_ext(spr_kranitron_walk, image_index, _x, _y, 4, 4, 0, c_white, 1);
if (state == 0 && fade > 0)
	draw_sprite_ext(spr_kranitron_stealth, 0, _x, _y, 4, 4, 0, c_white, fade);