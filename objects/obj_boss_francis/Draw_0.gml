/// @description 

var _i;
var _frame_delta = global.delta;

var _x_delta = lerp(x_start_frame, x, _frame_delta);
var _y_delta = lerp(y_start_frame, y, _frame_delta);
var _size_delta = lerp(size_multiplier_previous, size_multiplier, _frame_delta);

var _claw_left_pos_delta = lerp(claw_left_pos_previous, claw_left_pos, _frame_delta);
var _claw_left_angle_delta = lerp(claw_left_angle_previous, claw_left_angle, _frame_delta);
var _claw_left_x = _x_delta + lengthdir_x(112 * _size_delta, _claw_left_pos_delta);
var _claw_left_y = _y_delta + lengthdir_y(112 * _size_delta, _claw_left_pos_delta);

var _claw_right_pos_delta = lerp(claw_right_pos_previous, claw_right_pos, _frame_delta);
var _claw_right_angle_delta = lerp(claw_right_angle_previous, claw_right_angle, _frame_delta);
var _claw_right_x = _x_delta + lengthdir_x(112 * _size_delta, _claw_right_pos_delta);
var _claw_right_y = _y_delta + lengthdir_y(112 * _size_delta, _claw_right_pos_delta);

var _wing_left_x = _x_delta - (96 * _size_delta);
var _wing_right_x = _x_delta + (96 * _size_delta);
var _head_y = _y_delta - (112 * _size_delta);

var _angle_delta = buzzsaw_angle;
var _angle_draw;

if (_frame_delta < 1 && (buzzsaw_angle_previous != buzzsaw_angle))
	_angle_delta = lerp_360(buzzsaw_angle_previous, buzzsaw_angle, _frame_delta);

_angle_draw = (lengthdir_x(90, _angle_delta) + 270) mod 360;

draw_sprite_ext(spr_boss_francis_wing, 0, _wing_left_x, _y_delta, _size_delta * -1, _size_delta, 0, c_white, 1);
draw_sprite_ext(spr_boss_francis_wing, 0, _wing_right_x, _y_delta, _size_delta, _size_delta, 0, c_white, 1);

for (_i = 0; _i <= chain_segments; ++_i)
{
	draw_sprite(spr_chain, 0, x + lengthdir_x((_i * 32) * chain_size, _angle_draw), y + lengthdir_y((_i * 32) * chain_size, _angle_draw));
}
draw_sprite_interpolated(spr_sawful_blade, 0, x + buzzsaw_x, y + buzzsaw_y, x_start_frame + buzzsaw_x_previous, y_start_frame + buzzsaw_y_previous, 1, 1,,, buzzsaw_angle, buzzsaw_angle_previous);

if (global.difficulty == difficulty_levels.hard)
{
	for (_i = 0; _i <= chain_segments; ++_i)
	{
		draw_sprite(spr_chain, 0, x - lengthdir_x((_i * 32) * chain_size, _angle_draw), y + lengthdir_y((_i * 32) * chain_size, _angle_draw));
	}
	draw_sprite_interpolated(spr_sawful_blade, 0, x - buzzsaw_x, y + buzzsaw_y, x_start_frame - buzzsaw_x_previous, y_start_frame + buzzsaw_y_previous, 1, 1,,, buzzsaw_angle, buzzsaw_angle_previous);
}

draw_sprite_ext(spr_boss_francis_body, 0, _x_delta, _y_delta, _size_delta, _size_delta, 0, c_white, 1);
draw_sprite_ext(spr_boss_francis_head, cockpit_index, _x_delta, _head_y, _size_delta, _size_delta, 0, c_white, 1);
draw_sprite_ext(cockpit_sprite, cockpit_index, _x_delta, _y_delta, 1, 1, 0, c_white, 1);

if (claws_active)
{
	draw_sprite_ext(spr_boss_francis_claw, claw_left_index, _claw_left_x, _claw_left_y, 1, -1, _claw_left_angle_delta, c_white, 1);
	draw_sprite_ext(spr_boss_francis_claw, claw_right_index, _claw_right_x, _claw_right_y, 1, 1, _claw_right_angle_delta, c_white, 1);
}