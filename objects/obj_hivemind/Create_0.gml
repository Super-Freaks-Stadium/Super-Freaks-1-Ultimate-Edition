/// @description Init

// Inherit the parent event
event_inherited();

speed_walk = 0;

hitbox = new comp_hitbox_AABB(,,, enemy_hitbox_behaviors.heavy,, -30, -64, 30, -16);
animate_speed = 0;
timer = -delay;
deform_x = 1;
deform_y = 1;
deform_x_previous = 1;
deform_y_previous = 1;
yorb_amount = 10;
hp_init(2);
state_next_set(0);

collider_detector_up_set(-12, 0, 12, 0, -72);
collider_detector_down_set(-16, 0, 16, 0, 0);
collider_detector_sides_set(36, 36, 36, 36, 24);