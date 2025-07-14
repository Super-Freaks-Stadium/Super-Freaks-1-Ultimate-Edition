/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

var _laser_x1 = _x + hitbox_laser.shape_x1;
var _laser_y1 = _y + hitbox_laser.shape_y1;
var _laser_x2 = _x + hitbox_laser.shape_x2;
var _laser_y2 = _y + hitbox_laser.shape_y2;

draw_sprite_ext(spr_kranitron_walk, image_index, _x, _y, -4, 4, 0, c_white, 1);

draw_set_alpha(laser_alpha);
switch (state)
{
	case 2:
		draw_set_color(c_red);
		break;
	default:
		draw_set_color(c_gray);
		break;
}
draw_line_width(_laser_x1, _laser_y1, _laser_x2, _laser_y2, (96 * multiplier));
draw_set_alpha(1);
draw_set_color(c_white);