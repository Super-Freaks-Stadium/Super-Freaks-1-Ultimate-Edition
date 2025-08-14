/// @description Frame Begin

var _segment,
    _angle,
    _x_previous, _y_previous, _x, _y;

// Inherit the parent event
event_inherited();

for (_segment = segments; _segment >= 0; --_segment)
{
    _angle = hitbox[_segment][2][2];
    _x_previous = hitbox[_segment][2][0];
    _y_previous = hitbox[_segment][2][1];
    
    //hitbox[_segment][2] = variable_clone(hitbox[_segment][1][0]);
    hitbox[_segment][2][0] = hitbox[_segment][1][0][0];
    hitbox[_segment][2][1] = hitbox[_segment][1][0][1];
    _x = hitbox[_segment][2][0];
    _y = hitbox[_segment][2][1];
    if (_x != _x_previous && _y != _y_previous)
        hitbox[_segment][2][2] = point_direction(_x_previous, _y_previous, _x, _y);
}