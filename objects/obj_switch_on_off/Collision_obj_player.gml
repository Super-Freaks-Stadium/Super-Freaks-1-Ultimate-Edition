/// @description 

var _hitbox_self = global.hitbox_collision_stored[hitbox_collision_stored_data.hitbox];
var _hitbox_player = global.hitbox_collision_stored[hitbox_collision_stored_data.hitbox_other];
var _hitbox_self_x = _hitbox_self.x_offset + x;
var _hitbox_self_y = _hitbox_self.y_offset + y;
var _trigger_id = trigger_id;

with (other)
{
	if (ball)
	{
		speed_h = 3 * sign(((x + x_start_frame) / 2) - _hitbox_self_x);
		speed_v = 3 * sign(((y + y_start_frame) / 2) - _hitbox_self_y);
		while (hitbox_collision_check(_hitbox_self, _hitbox_player))
		{
			x += speed_h * 2;
			y += speed_v * 2;
		}
		lock_controls_horizontal = 20;
		trigger_toggle(_trigger_id);
		sfx_play_global(sfx_ding);
		sfx_play_local(sfx_hit);
	}
}