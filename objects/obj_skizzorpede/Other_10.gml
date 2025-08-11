/// @description Step

var _array_length;
var _segment, _segment_previous, _segment_x_previous, _segment_y_previous;
var _path_pos, _path_x, _path_y, _path_x_next, _path_y_next;
var _my_x, _my_y;

event_inherited();

my_path_pos += speed_normalized;
if (my_path_pos < 0)
    my_path_pos++;
else
    my_path_pos = my_path_pos mod 1;
_path_pos = my_path_pos;

for (_segment = 0; _segment <= segments; ++_segment)
{
    _path_x = path_get_x(my_path, _path_pos);
    _path_y = path_get_y(my_path, _path_pos);
    
    _path_pos -= SKIZZORPEDE_SEGMENT_LENGTH * sign(speed_path);
    if (_path_pos < 0)
        _path_pos++;
    else
        _path_pos = _path_pos mod 1;
    _path_x_next = path_get_x(my_path, _path_pos);
    _path_y_next = path_get_y(my_path, _path_pos);
    
    _my_x = _path_x - x;
    _my_y = _path_y - y;
    
    with (hitbox[_segment])
    {
        body.x_offset = _my_x;
        body.y_offset = _my_y;
        angle = point_direction(_path_x_next, _path_y_next, _path_x, _path_y);
    }
}