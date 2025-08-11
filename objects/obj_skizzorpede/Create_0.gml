/// @description Init
var _segment, 
    _path_pos, _path_x, _path_y;

// Inherit the parent event
event_inherited();

my_path_pos_start = path_closest_point(my_path, x, y);
my_path_pos = my_path_pos_start;
speed_path = my_speed;
speed_normalized = 1 / (path_get_length(my_path) / my_speed);
SKIZZORPEDE_SEGMENT_LENGTH = 1 / (path_get_length(my_path) / 32);

animate_speed = 0.125;

hitbox = [];

_path_pos = my_path_pos_start;
if (_path_pos < 0)
    _path_pos++;
else
    _path_pos = _path_pos mod 1;

for (_segment = 0; _segment <= segments; ++_segment)
{
    if (_path_pos < 0)
        _path_pos++;
    else
        _path_pos = _path_pos mod 1;
    _path_x = path_get_x(my_path, _path_pos) - x;
    _path_y = path_get_y(my_path, _path_pos) - ystart;
    
    hitbox[_segment] = 
    {
        body: new comp_hitbox_circle( _path_x, _path_y,, enemy_hitbox_behaviors.hazard,, 16 ),
        x_previous: _path_x,
        y_previous: _path_y,
        angle: 0,
        angle_previous: 0,
    };
    _path_pos -= SKIZZORPEDE_SEGMENT_LENGTH * sign(speed_path);
}