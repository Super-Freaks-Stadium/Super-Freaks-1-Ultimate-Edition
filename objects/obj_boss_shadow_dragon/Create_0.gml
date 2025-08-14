/// @description Init
var _segment, _i;

// Inherit the parent event
event_inherited();

segments = 6;
SKIZZORPEDE_SEGMENT_LENGTH = floor(24 / abs(speed));
timer = 256;

animate_speed = 0.125;
sfx_play_global(sfx_flame);

hitbox = [];

for (_segment = 0; _segment <= segments; ++_segment)
{
	hitbox[_segment][0] = new comp_hitbox_circle(,,, enemy_hitbox_behaviors.hazard,, 16);
	hitbox[_segment][1] = [];
    hitbox[_segment][2] = [x, y, 90];
	
	for (_i = 0; _i <= SKIZZORPEDE_SEGMENT_LENGTH; ++_i)
	{
		array_insert(hitbox[_segment][1], 0, [x, y]);
	}
}