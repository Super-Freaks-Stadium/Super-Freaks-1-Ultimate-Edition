/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _angle = lerp(angle_previous, angle, _frame_delta);
var _laser_angle = lerp(laser_angle_previous, laser_angle, _frame_delta);
var _gun_left_x = _x + lerp(gun_left_previous.x_offset, gun_left.x_offset, _frame_delta);
var _gun_left_y = _y + lerp(gun_left_previous.y_offset, gun_left.y_offset, _frame_delta);
var _gun_right_x = _x + lerp(gun_right_previous.x_offset, gun_right.x_offset, _frame_delta);
var _gun_right_y = _y + lerp(gun_right_previous.y_offset, gun_right.y_offset, _frame_delta);
var _laser_left_x = _x + lerp(laser_left_previous.x_offset, laser_left.x_offset, _frame_delta);
var _laser_left_y = _y + lerp(laser_left_previous.y_offset, laser_left.y_offset, _frame_delta);
var _laser_left_x2 = _laser_left_x + lerp(laser_left_previous.shape_x2, laser_left.shape_x2, _frame_delta);
var _laser_left_y2 = _laser_left_y + lerp(laser_left_previous.shape_y2, laser_left.shape_y2, _frame_delta);
var _laser_right_x = _x + lerp(laser_right_previous.x_offset, laser_right.x_offset, _frame_delta);
var _laser_right_y = _y + lerp(laser_right_previous.y_offset, laser_right.y_offset, _frame_delta);
var _laser_right_x2 = _laser_right_x + lerp(laser_right_previous.shape_x2, laser_right.shape_x2, _frame_delta);
var _laser_right_y2 = _laser_right_y + lerp(laser_right_previous.shape_y2, laser_right.shape_y2, _frame_delta);
var _laser_color = 45 + lengthdir_x(45, laser_color);

draw_sprite_ext(spr_boss_skullmobile_gun, 0, _gun_left_x, _gun_left_y, 1, 1, _laser_angle + 180, c_white, 1);
draw_sprite_ext(spr_boss_skullmobile_gun, 0, _gun_right_x, _gun_right_y, 1, 1, _laser_angle, c_white, 1);
draw_set_color(make_color_rgb(255, _laser_color, _laser_color));
if (laser_left.active == hitbox_active.passive)
{
	draw_circle(_laser_left_x, _laser_left_y, 16, false);
	draw_line_width(_laser_left_x, _laser_left_y, _laser_left_x2, _laser_left_y2, 32);
}
if (laser_right.active == hitbox_active.passive)
{
	draw_circle(_laser_right_x, _laser_right_y, 16, false);
	draw_line_width(_laser_right_x, _laser_right_y, _laser_right_x2, _laser_right_y2, 32);
}
draw_set_color(c_white);
draw_sprite_ext(spr_boss_skullmobile, image_index, _x, _y, 1, 1, _angle, c_white, 1);