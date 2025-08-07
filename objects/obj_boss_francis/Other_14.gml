/// @description Frame Begin

// Inherit the parent event
event_inherited();

buzzsaw_x_previous = buzzsaw_x;
buzzsaw_y_previous = buzzsaw_y;
buzzsaw_angle_previous = buzzsaw_angle;

if (buzzsaw_angle < 0)
{
    buzzsaw_angle += 360;
    buzzsaw_angle_previous += 360;
}
else if (buzzsaw_angle >= 360)
{
    buzzsaw_angle -= 360;
    buzzsaw_angle_previous -= 360;
}

claw_left_angle_previous = claw_left_angle;
claw_left_pos_previous = claw_left_pos;

claw_right_angle_previous = claw_right_angle;
claw_right_pos_previous = claw_right_pos;
