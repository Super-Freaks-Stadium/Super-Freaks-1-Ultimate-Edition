/// @description Init

// Inherit the parent event
event_inherited();

timer = 0;
animate_speed = 0;
fast_forward = false;

sfx_play_local(sfx_petah_knee);

depth = -1;
ground_on = false;
speed_v = 0;
speed_grv = 0.25;

collider_detector_down_set(,,,, 24);