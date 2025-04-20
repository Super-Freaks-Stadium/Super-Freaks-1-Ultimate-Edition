/// @description Init

// Inherit the parent event
event_inherited();

enum BOSS_KRANION_CLONE_STATES
{
	INTRO = 0,
	IDLE,
    DEATH,
}

timer = 0;
teleport_timer = 0;
speed_h = 0;
speed_v = 0;
animate_speed = 0.15;

hp = 4;

hitbox = new comp_hitbox_circle(, 8, hitbox_active.inactive, enemy_hitbox_behaviors.heavy,, 64);

collider_detector_sides_set(-40,, 40,, 80);
collider_detector_up_set(-40,, 40,, -60);
collider_detector_down_set(-40,, 40,, 64);