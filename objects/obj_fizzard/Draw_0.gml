/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

if (blink)
	gpu_set_fog(1, c_red, 0, 0);
draw_sprite(sprite_index, image_index, _x, _y);
if (blink)
	gpu_set_fog(0, c_white, 0, 0);
	
if (state == 1 && animate_speed == 0)
{
	draw_set_color(c_red);
	draw_line_width(_x, _y, _x, attack_y, 4);
	draw_set_color(c_white);
}