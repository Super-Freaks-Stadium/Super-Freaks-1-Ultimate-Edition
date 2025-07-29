/// @description 

var _hitbox_self = global.hitbox_collision_stored[hitbox_collision_stored_data.hitbox];

if (_hitbox_self == hitbox)
{
	if (other.hit)
	{
		enemy_hurt();
		if (global.boss_phase == 1)
        {
            if (irandom_range(0, 1))
			    laser_rotate_speed = -laser_rotate_speed;
        }
		with (other)
			instance_destroy();
	}
}