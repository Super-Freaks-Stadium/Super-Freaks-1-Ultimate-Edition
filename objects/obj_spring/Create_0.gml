/// @description Init

var _width, _width_half;

// Inherit the parent event
event_inherited();

image_xscale = abs(image_xscale);
image_yscale = 1;
_width = image_xscale * sprite_get_width(sprite_index);
_width_half = _width / 2;

image_index = 0;
animate_speed = 0;

collider = new comp_collider_AABB(,, -_width_half, -24, _width_half, 1);
with (collider)
{
	solid_y1 = collider_solidity.semi_solid;
	callback[1] = function()
	{
		var _collider = global.collider_collision[collider_collision.collider];
		var _owner = _collider.owner;
		
		collision_flag_clear_down();
		speed_v = -10;
		sfx_play_local(sfx_spring);
		
		if (object_index == obj_player && player_is_alive())
		{
			state_next_set(player_states.normal, 9);
			player_physics_set_normal();
		}
		
		with (_owner)
		{
			image_index = 1;
			animate_speed = 0.25;
		}
	}
}

despawn_area[0] = -_width_half;
despawn_area[1] = -32;
despawn_area[2] = _width_half;
despawn_area[3] = 1;