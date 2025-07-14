/// @description Draw

var _arm_angle = 315;
if (face == -1)
	_arm_angle = 225;

draw_sprite_interpolated(sprite_index, image_index, x, y,,, face, 1,,, 0,, c_white, 1, global.delta);

var _arm_length = lerp(arm_length_previous, arm_length, global.delta)

if ((sprite_index == spr_megaklaw_punch and image_index >= 3) or (sprite_index == spr_megaklaw_spit) or (sprite_index == spr_megaklaw_stuck))//(arm_length > 0)
{
	draw_sprite_ext(spr_megaklaw_arm, 0, x + -10 * face, y + 17, _arm_length * 1.5, 1, _arm_angle, c_white, 1);
	draw_sprite_ext(spr_megaklaw_claw, 0, x + (_arm_length - 10) * face, y + 17 + _arm_length, face, 1, 0, c_white, 1);
}