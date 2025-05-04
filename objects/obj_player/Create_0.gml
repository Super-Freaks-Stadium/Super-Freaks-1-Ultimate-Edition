/// @description Init

var _hitbox_size;

// Inherit the parent event
event_inherited();

player_number = 0;
character_index = 0;

#region Controls
	lock_controls_horizontal = 0;
	lock_controls_vertical = 0;
	lock_friction = 0;
	lock_gravity = 0;
#endregion

#region Physics
	#macro AURA_WALK 2
	#macro AURA_JUMP 2
	player_physics_set_normal();

	face = 1;
	angle = 0;
	angle_ground = 0;
#endregion

#region Abilities
    #macro SPRINT_MAX 10
    #macro SPRINT_ADD 0.0125
    sprint = 0;
    sprint_cloud_timer = 0;
	ball = false;
	skid = false;
	walljump_auto = 0;
	#macro WALLJUMP_AUTO_MAX 48
	
	rubber_band = false;
	rubber_band_can_slingshot = false;
	rubber_band_color = 0;
	rubber_band_average_x = x;
	rubber_band_average_y = y;
	
	underwater = false;
	water_meter = 100;
	
	#macro HANG_DISMOUNT_FRAMES_MAX 6
	hang_dismount_frames = 0;
	hang_on = false;
	invincible = false;
	
	flashlight_radius = 72;
	
	jetpack = false;
	#macro JETPACK_JUMP_TIMER_MAX 48
	jetpack_jump_timer = 0;
	jetpack_index = 0;
	
	gravity_modifier = 0;
	fall_speed_modifier = 0;

	ground_on = false;
	platform_jump_off = false;
	coyote_time = 0;
	#macro COYOTE_TIME_MAX 8
	jump_buffer = 0;
	#macro JUMP_BUFFER_MAX 8
	etc_buffer = 0;
	#macro JUMP_STRENGTH_MAX 20
	#macro JUMP_STRENGTH_MIN 0
    #macro ANTI_FREAK_WEAK 15
	jump_strength = JUMP_STRENGTH_MIN;
	
	hp = 0;
	ego_invincible = 0;
	ego_refill_pause = 0;
	#macro AURA_INVINCIBLE 30
	aura = 0;
	aura_stored = undefined;
	can_fireball = true;
#endregion

#region Collision
	_hitbox_size = player_hitbox_get(character_index);
	hitbox = new comp_hitbox_AABB(,, hitbox_active.active,,, _hitbox_size.x1, _hitbox_size.y1, _hitbox_size.x2, _hitbox_size.y2);
	//hitbox = new comp_hitbox_AABB(,, hitbox_active.active,,, -8, -12, 8, 20);
	hurt_timer_set(0);
	
	//switch (global.story_mode)
	//{
	//	default:
			collider_detector_up_set(-6, 0, 6, 0, -16);
			collider_detector_sides_set(-8, 0, 16, 0, 14);
			collider_detector_down_set(-8, 0, 8, 0, 24);
	//		break;
	//	case story_modes.kranion:
	//		collider_detector_up_set(-10, 0, 10, 0, -24);
	//		collider_detector_sides_set(-12, 0, 18, 0, 18);
	//		collider_detector_down_set(-12, 0, 12, 0, 32);
	//		break;
	//}
	
	behavior_ceiling = 0;
	behavior_floor = 0;
	behavior_wall = 0;
	behavior_wall_left = 0;
	behavior_wall_right = 0;
	
	crush_flags = 0;
#endregion

camera = new comp_camera();
timer_death = 0;

depth = 0;
