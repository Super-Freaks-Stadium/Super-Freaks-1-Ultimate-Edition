/// @description Draw

var _i;
var _frame_delta = global.delta;
var _width = abs(image_xscale * sprite_get_width(sprite_index)), _width_half = _width / 2;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _x1 = _x - _width_half, _x2 = _x + _width_half;
var _offset_delta = lerp(offset_previous, offset, _frame_delta);
var _tops_to_draw = floor(_width / 16) - 1;

if (!in_view(bbox_left, bbox_top, bbox_right, bbox_bottom))
	exit;
	
draw_sprite_ext(spr_conveyor_belt, image_index, _x, _y, image_xscale, 1, 0, c_white, 1);

draw_sprite_part(spr_conveyor_belt_top, 0, _offset_delta, 0, 16, 16, _x1 + 8, _y - 32);
for (_i = 1; _i < _tops_to_draw; ++_i)
{
	draw_sprite(spr_conveyor_belt_top, 0, _x1 + 8 - _offset_delta + (16 * _i), _y - 32);
}
draw_sprite_part(spr_conveyor_belt_top, 0, 0, 0, _offset_delta, 16, _x2 - 8 - _offset_delta, _y - 32);