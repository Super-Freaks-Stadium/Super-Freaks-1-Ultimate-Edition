/// @description 

var _hitbox_size = player_hitbox_get(character_index);

switch (state)
{
	case player_states.debug:
	case player_states.inactive:
	case player_states.drop_in:
		switch (global.story_mode)
		{
			case story_modes.super_freaks:
				break;
			default:
				ego_invincible = 0;
				ego_refill_pause = 0;
				aura = 0;
				hp = 0;
				break;
		}
		break;
	case player_states.death:
	case player_states.death_fall:
		invincible = false;
		switch (global.story_mode)
		{
			case story_modes.super_freaks:
				break;
			default:
				ego_invincible = 0;
				ego_refill_pause = 0;
				aura = 0;
				hp = 0;
				break;
		}
	case player_states.bubble:
		state_next_set(player_states.normal);
		camera.active = true;
		hurt_timer_set(120);
		music_resume();
		break;
	default:
		state_next_set(player_states.normal);
		camera.active = true;
		hurt_timer_set(0);
		break;
}

face = 1;
ball = false;
speed_h = 0;
speed_v = 0;
ground_on = false;
instance_attach = undefined;
water_meter = 100;
jump_strength = JUMP_STRENGTH_MIN;

lock_controls_horizontal = 0;
lock_controls_vertical = 0;
lock_friction = 0;
lock_gravity = 0;
star_arrow = 0;

x_previous = x;
y_previous = y;
camera.x = x;
camera.y = y;
camera.xprevious = x;
camera.yprevious = y;

timer_death = 0;
jetpack = false;

with (hitbox)
{
	shape_x1 = _hitbox_size.x1;
	shape_y1 = _hitbox_size.y1;
	shape_x2 = _hitbox_size.x2;
	shape_y2 = _hitbox_size.y2;
}