enum player_physics_modifiers
{
	normal = 0,
	ice,
	slime,
	rail,
}

/// @function player_physics_set_normal
function player_physics_set_normal()
{
	speed_acc = 0.3;
	speed_acc_air = 0.3;
	speed_dec = 0.3;
	speed_dec_air = 0.25;
	speed_frc = 0.3;
	speed_frc_air = 0.96875;
	speed_grv = 0.25;

	speed_jump = 7.15;
	speed_run = 3.25;
	speed_fall = 6;
	
	physics = player_physics_modifiers.normal;
    
    if (global.turbo.mode)
        speed_run = 4.25;
}

/// @function player_physics_set_ice
function player_physics_set_ice()
{
	speed_acc = 0.05;
	speed_acc_air = 0.05;
	speed_dec = 0.05;
	speed_dec_air = 0.25;
	speed_frc = 0.05;
	speed_frc_air = 0.96875;
	speed_grv = 0.25;

	speed_jump = 7.15;
	speed_run = 3.25;
	speed_fall = 6;
	
	physics = player_physics_modifiers.ice;
    
    if (global.turbo.mode)
        speed_run = 4.25;
}

/// @function player_friction_normal
/// @param _speed_frc = speed_frc
/// @param _speed_frc_air = speed_frc_air
function player_friction_normal(_speed_frc = speed_frc, _speed_frc_air = speed_frc_air)
{
	if (ground_on)
	{
		if (lock_friction == 0)
			speed_h -= min(abs(speed_h), _speed_frc) * sign(speed_h);
		if (speed_h == 0)
			skid = false;
	}
	else
	{
		if (lock_friction == 0 && platform_jump_off == false)
			speed_h *= _speed_frc_air;
	}
}

///@function player_rubberband_physics
function player_rubberband_physics()
{
	var _move_x_sign = 0;
	var _average_x, _average_y, _average_x_previous, _average_y_previous;
	var _facing_average_x_sign = 0, _dist_to_average = 0;
	var _bottom_y = 0;
	
	_average_x = global.player_rubberband_average[rubber_band_color][0];
	_average_y = global.player_rubberband_average[rubber_band_color][1];
	_average_x_previous = global.player_rubberband_average_previous[rubber_band_color][0];
	_average_y_previous = global.player_rubberband_average_previous[rubber_band_color][1];
	
	if (!player_is_alive() || !rubber_band || is_undefined(_average_x))
		exit;
	
	_move_x_sign = sign(x - x_previous);
	_dist_to_average = point_distance(x, y, _average_x, _average_y);
	_facing_average_x_sign = sign(x - _average_x);
	_bottom_y = max(_average_y, _average_y + lengthdir_y(96, point_direction(_average_x, _average_y, x, y)));
	
    //Horizontal Movement
	if (x < _average_x - 96)
	{
		if (_move_x_sign == -1)
			_average_x += (x - (_average_x - 96));
		else
			speed_h += 0.5;
	}
	else if (x > _average_x + 96)
	{
		if (_move_x_sign == 1)
			_average_x += (x - (_average_x + 96));
		else
			speed_h -= 0.5;
	}
	
    //Vertical Movement
    if (y > _bottom_y)
    {
		ground_on = false;
			
	    if (input_check("down", player_number) && rubber_band_can_slingshot == true)
			speed_v += 0.35 / (96 / distance_to_point(x, _average_y));
	    else
			speed_v -= 2 / (96 / distance_to_point(x, _average_y));
			
	    speed_h -= 0.5 * _facing_average_x_sign;
    }
}