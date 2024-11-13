/// @description Init

// Inherit the parent event
event_inherited();

rotate_effect = 0;
rotate_effect_previous = 0;
rotate_speed = 2;
scale_effect_timer = 0;
scale_effect_previous = 0;
scale_effect = 1;
fast_forward = false;

hitbox = new comp_hitbox_circle(,,,,, 32);
