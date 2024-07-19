/// @description 

var _frame_delta = frame_delta_level_get();
var _segment, _segment_position_array, _segment_x, _segment_x_previous, _segment_x_delta, _segment_y, _segment_y_previous, _segment_y_delta;

for (_segment = segments; _segment > 0; --_segment)
{
	_segment_position_array = hitbox[_segment][1];
	_segment_x = _segment_position_array[0][0];
	_segment_y = _segment_position_array[0][1];
	_segment_x_previous = _segment_position_array[1][0];
	_segment_y_previous = _segment_position_array[1][1];
	_segment_x_delta = lerp(_segment_x_previous, _segment_x, _frame_delta);
	_segment_y_delta = lerp(_segment_y_previous, _segment_y, _frame_delta);
	draw_sprite_ext(spr_boss_shadow_dragon_body, image_index, _segment_x_delta, _segment_y_delta, 1, 1, point_direction(_segment_x_delta, _segment_y_delta, _segment_x, _segment_y), c_white, 1);
}

_segment = 0;
_segment_position_array = hitbox[_segment][1];
_segment_x = _segment_position_array[0][0];
_segment_y = _segment_position_array[0][1];
_segment_x_previous = _segment_position_array[1][0];
_segment_y_previous = _segment_position_array[1][1];
_segment_x_delta = lerp(_segment_x_previous, _segment_x, _frame_delta);
_segment_y_delta = lerp(_segment_y_previous, _segment_y, _frame_delta);
draw_sprite_ext(spr_boss_shadow_dragon_head, image_index, _segment_x_delta, _segment_y_delta, 1, 1, point_direction(_segment_x_delta, _segment_y_delta, _segment_x, _segment_y), c_white, 1);