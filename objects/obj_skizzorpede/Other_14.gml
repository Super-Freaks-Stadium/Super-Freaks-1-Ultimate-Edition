/// @description Frame Start

var _segment;

// Inherit the parent event
event_inherited();

for (_segment = 0; _segment <= segments; ++_segment)
{
    with (hitbox[_segment])
    {
        x_previous = body.x_offset;
        y_previous = body.y_offset;
        angle_previous = angle;
    };
}