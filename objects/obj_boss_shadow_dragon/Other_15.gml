/// @description Death

var _frame_delta = global.delta;
var _segment, _segment_position_array, _segment_x, _segment_x_previous, _segment_x_delta, _segment_y, _segment_y_previous, _segment_y_delta;

_segment = 0;
_segment_position_array = hitbox[_segment][1];
_segment_x = _segment_position_array[0][0];
_segment_y = _segment_position_array[0][1];
_segment_x_previous = _segment_position_array[1][0];
_segment_y_previous = _segment_position_array[1][1];
_segment_x_delta = lerp(_segment_x_previous, _segment_x, _frame_delta);
_segment_y_delta = lerp(_segment_y_previous, _segment_y, _frame_delta);

enemy_killed_create(,, sprite_index, image_index,,,, point_direction(_segment_x_delta, _segment_y_delta, _segment_x, _segment_y), player_hit_speed_x,);
yorbs_add(yorb_amount);
yorb_collect_effect_multi(,, yorb_amount);
sfx_play_global(sfx_zip);
instance_destroy();