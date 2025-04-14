
var _i, _arm_seg_length;
var _frame_delta = frame_delta_level_get();
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _arm_length = lerp(arm_length_previous, arm_length, _frame_delta);
var _arm_angle_left = lerp(-arm_angle_previous, -arm_angle, _frame_delta);
var _arm_angle_right = lerp(arm_angle_previous, arm_angle, _frame_delta);

if (state == boss_milkman_states.intro_1)
	draw_sprite(spr_milkman_intro, image_index, _x, _y);
else
{
	draw_sprite(spr_milkman_body, image_index, _x, _y);
	if (global.boss_phase < 2)
		draw_sprite(spr_milkman_arms, image_index, _x, _y);
	else
	{
		for (_i = 0; _i < array_length(arm[0]); ++_i)
		{
			_arm_seg_length = _arm_length * 16 * _i;
			draw_sprite(spr_chain, 0, _x - 80 + lengthdir_x(_arm_seg_length, _arm_angle_left), _y + arm_offset + lengthdir_y(_arm_seg_length, _arm_angle_left));
		}
		_arm_seg_length = _arm_length * 16 * (array_length(arm[0]) - 1);
		draw_sprite_ext(spr_sawful_blade, 0, _x - 80 + lengthdir_x(_arm_seg_length, _arm_angle_left), _y + arm_offset + lengthdir_y(_arm_seg_length, _arm_angle_left), 1, 1, _arm_angle_left, c_white, 1);

		for (_i = 0; _i < array_length(arm[1]); ++_i)
		{
			_arm_seg_length = _arm_length * 16 * _i;
			draw_sprite(spr_chain, 0, _x + 80 + lengthdir_x(_arm_seg_length, _arm_angle_right), _y + arm_offset + lengthdir_y(_arm_seg_length, _arm_angle_right));
		}
		_arm_seg_length = _arm_length * 16 * (array_length(arm[1]) - 1);
		draw_sprite_ext(spr_sawful_blade, 0, _x + 80 + lengthdir_x(_arm_seg_length, _arm_angle_right), _y + arm_offset + lengthdir_y(_arm_seg_length, _arm_angle_right), 1, 1, _arm_angle_right, c_white, 1);
	}
}