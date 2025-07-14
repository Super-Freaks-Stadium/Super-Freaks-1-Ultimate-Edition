/// @description Draw

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

draw_sprite_interpolated(sprite_index,,,,,,,,,, face * 90,,,, _frame_delta);

draw_set_color(c_lime);
switch (face)
{
	case 0: //Right
		draw_line_width(_x + 24, _y, attack_x, _y, 4);
		break;
	case 1: //Up
		draw_line_width(_x, _y - 24, _x, attack_y, 4);
		break;
	case 2: //Left
		draw_line_width(_x - 24, _y, attack_x, _y, 4);
		break;
	case 3: //Down
		draw_line_width(_x, _y + 24, _x, attack_y, 4);
		break;
}
draw_set_color(c_white);
