/// @description 

var _i;

var _frame_delta = global.delta;
var _angle_delta = angle;
var _angle_draw;

if (_frame_delta < 1 && (angle_previous != angle))
	_angle_delta = lerp_360(angle_previous, angle, _frame_delta);

_angle_draw = (lengthdir_x(90, _angle_delta) + 270) mod 360;

if (blink)
	gpu_set_fog(1, c_red, 0, 0);
for (_i = 0; _i <= chain_segments; ++_i)
{
	draw_sprite(spr_chain, 0, x + lengthdir_x(_i * (32 * chain_multiplier), _angle_draw), y + lengthdir_y(_i * (32 * chain_multiplier), _angle_draw));
}

draw_sprite_interpolated(spr_boss_spike_spikes, 0, x + thing_x, y + thing_y, x_start_frame + thing_x_previous, y_start_frame + thing_y_previous, spike_size, spike_size,,, _angle_draw + 90, _angle_draw + 90);
draw_sprite_interpolated(sprite_index, image_index, x + thing_x, y + thing_y, x_start_frame + thing_x_previous, y_start_frame + thing_y_previous, image_xscale, image_yscale,,, _angle_draw + 90, _angle_draw + 90);
if (blink)
	gpu_set_fog(0, c_white, 0, 0);