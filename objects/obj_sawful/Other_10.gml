/// @description Step

event_inherited();

buzzsaw_angle += 30;
if (buzzsaw_angle >= 360)
{
    buzzsaw_angle -= 360;
    buzzsaw_angle_previous -= 360;
}

path_move(my_path, path_end_actions.reverse);