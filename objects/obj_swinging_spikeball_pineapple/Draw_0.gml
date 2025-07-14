/// @description 

var _i;

var _frame_delta = global.delta;
var _angle_delta = angle;
var _angle_draw;

if (_frame_delta < 1 && (angle_previous != angle))
	_angle_delta = lerp_360(angle_previous, angle, _frame_delta);

if (circle_angle == 360)
	_angle_draw = (_angle_delta + 270) mod 360;
else
	_angle_draw = (lengthdir_x(circle_angle, _angle_delta) + 270) mod 360;
	
for (_i = 0; _i <= chain_segments; ++_i)
{
	draw_sprite(spr_chain, 0, x + lengthdir_x(_i * 32, _angle_draw), y + lengthdir_y(_i * 32, _angle_draw));
}

draw_sprite_interpolated(sprite_index, 0, x + thing_x, y + thing_y, x_start_frame + thing_x_previous, y_start_frame + thing_y_previous, image_xscale, image_yscale,,, _angle_draw + 90, _angle_draw + 90);