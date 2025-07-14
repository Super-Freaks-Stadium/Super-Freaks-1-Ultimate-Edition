/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

draw_sprite_ext(sprite_index, image_index, _x, _y, face, 1, 0, c_white, 1);

if (laser.active != hitbox_active.inactive)
{
	draw_set_color(c_lime);
	draw_line_width(_x, _y + 24, _x, attack_y, 4);
	draw_set_color(c_white);
}
