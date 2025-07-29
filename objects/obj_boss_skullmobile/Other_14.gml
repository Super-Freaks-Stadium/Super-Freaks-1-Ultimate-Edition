/// @description Frame Begin

// Inherit the parent event
event_inherited();

angle_previous = angle;

laser_distance_previous = laser_distance;
laser_angle_previous = laser_angle;

gun_left_previous = {x_offset: gun_left.x_offset, y_offset: gun_left.y_offset};
gun_right_previous = {x_offset: gun_right.x_offset, y_offset: gun_right.y_offset};
laser_left_previous = {x_offset: laser_left.x_offset, y_offset: laser_left.y_offset, shape_x2: laser_left.shape_x2, shape_y2: laser_left.shape_y2};
laser_right_previous = {x_offset: laser_right.x_offset, y_offset: laser_right.y_offset, shape_x2: laser_right.shape_x2, shape_y2: laser_right.shape_y2};