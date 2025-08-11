/// @description 

var _frame_delta = global.delta;
var _segment, _segment_position_array, _segment_x, _segment_x_previous, _segment_x_delta, _segment_y, _segment_y_previous, _segment_y_delta, _angle;
var _my_x = x, _my_y = y, _my_x_previous = x_previous, _my_y_previous = y_previous;

//draw_path(my_path, xstart, ystart, true);

for (_segment = segments; _segment > 0; --_segment)
{
    with (hitbox[_segment])
    {
        _segment_x_previous = _my_x_previous + x_previous;
        _segment_y_previous = _my_y_previous + y_previous;
        _segment_x = _my_x + body.x_offset;
        _segment_y = _my_y + body.y_offset;
        _segment_x_delta = lerp(_segment_x_previous, _segment_x, _frame_delta);
        _segment_y_delta = lerp(_segment_y_previous, _segment_y, _frame_delta);
        _angle = lerp_360(angle_previous, angle, _frame_delta);
        //_angle = angle;
    }
	draw_sprite_ext(spr_skizzorpede_body, 0, _segment_x_delta, _segment_y_delta, 1, 1, _angle, c_white, 1);
}
with (hitbox[0])
{
    _segment_x_previous = _my_x_previous + x_previous;
    _segment_y_previous = _my_y_previous + y_previous;
    _segment_x = _my_x + body.x_offset;
    _segment_y = _my_y + body.y_offset;
    _segment_x_delta = lerp(_segment_x_previous, _segment_x, _frame_delta);
    _segment_y_delta = lerp(_segment_y_previous, _segment_y, _frame_delta);
    _angle = lerp_360(angle_previous, angle, _frame_delta);
    //_angle = angle;
}
draw_sprite_ext(spr_skizzorpede_head, image_index, _segment_x_delta, _segment_y_delta, 1, 1, _angle, c_white, 1);