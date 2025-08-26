/// @description Init

// Inherit the parent event
event_inherited();

hp_init(2);

collider_detector_up_set(0, 0, 0, 0, -40);
collider_detector_down_set(0, 0, 0, 0, 72);
collider_detector_sides_set(-16, 0, 16, 0, 48);

hitbox.shape_x1 = -32;
hitbox.shape_y1 = -32;
hitbox.shape_x2 = 32;
hitbox.shape_y2 = 32;
hitbox.behavior = enemy_hitbox_behaviors.heavy;

yorb_amount = 10;

despawn_area[0] = sprite_get_bbox_left(sprite_index);
despawn_area[1] = sprite_get_bbox_top(sprite_index);
despawn_area[2] = sprite_get_bbox_right(sprite_index);
despawn_area[3] = sprite_get_bbox_bottom(sprite_index);

state_next_set(0);
timer = 0;
fast = fast_forward;