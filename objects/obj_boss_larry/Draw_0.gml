/// @description

var _frame_delta = global.delta;

if (blink)
	gpu_set_fog(1, c_red, 0, 0);
if (state == 1)
	draw_sprite_interpolated(spr_boss_larry_spikes,,,,,, image_xscale, image_yscale,,, angle, angle_previous,, image_alpha, _frame_delta);
draw_sprite_interpolated(sprite_index,,,,,, image_xscale, image_yscale,,, angle, angle_previous,, image_alpha, _frame_delta);
if (blink)
	gpu_set_fog(0, c_white, 0, 0);