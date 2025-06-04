/// @description Init

// Inherit the parent event
event_inherited();

#macro MISSILE_LIMIT_EASY 2
#macro MISSILE_LIMIT_NORMAL 3
#macro MISSILE_LIMIT_HARD 3

hitbox = new comp_hitbox_circle(,,,,,8);
collider_detector_up_set(0, 0, 0, 0, -8);
collider_detector_down_set(0, 0, 0, 0, 8);
collider_detector_sides_set(0, 0, 0, 0, 8);
animate_speed = 0.25;
flashlight_radius = 36;