/// @description Init

// Inherit the parent event
event_inherited();

spin_angle_previous = 0;
spin_angle = 0;
spin_length_previous = 0;
spin_length = 0;
spin_visual = 0;
timer = 0;

state_next_set(0);

hitbox = new comp_hitbox_circle(,,,,, 24);
hitbox_x_offset_previous = hitbox.x_offset;
hitbox_y_offset_previous = hitbox.y_offset;

despawn_area[0] = min(x - 32, destination_x - 32) - x;
despawn_area[1] = min(y - 32, destination_y - 32) - y;
despawn_area[2] = max(x + 32, destination_x + 32) - x;
despawn_area[3] = max(y + 32, destination_y + 32) - y;