/// @description 

var _i;
var _frame_delta = global.delta;
var _offset_delta = lerp(offset_previous, offset, _frame_delta);
var _poles_to_draw = floor(image_yscale);

draw_sprite_part(sprite_index, 0, 0, _offset_delta, 16, 16, x - 8, y);

for (_i = 1; _i < _poles_to_draw; ++_i)
{
	draw_sprite(sprite_index, 0, x, y - _offset_delta + (16 * _i));
}

draw_sprite_part(sprite_index, 0, 0, 0, 16, _offset_delta, x - 8, y + (_poles_to_draw * 16) - _offset_delta);