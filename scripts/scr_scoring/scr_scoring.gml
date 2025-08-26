#macro TURBO_TIME_MAX 30

enum game_timer_data
{
	pause = 0,
	ticks,
	seconds,
	minutes,
	hours,
}

/// @function scoring_init
function scoring_init()
{
	global.game_timer = array_create(5);
	global.score = 0;
}

/// @function game_timer_step
function game_timer_step()
{
	var _ticks = global.game_timer[game_timer_data.ticks];
	var _seconds = global.game_timer[game_timer_data.seconds];
	var _minutes = global.game_timer[game_timer_data.minutes];
	var _hours = global.game_timer[game_timer_data.hours];
	
	if (global.game_timer[game_timer_data.pause] == true || _hours == 99)
		exit;
	
	_ticks++;
	if (_ticks == 60)
	{
		_ticks = 0;
		_seconds++;
	}
	
	if (_seconds == 60)
	{
		_seconds = 0;
		_minutes++;
	}
	
	if (_minutes == 60)
	{
		_minutes = 0;
		_hours++;
	}
	
	global.game_timer[game_timer_data.ticks] = _ticks;
	global.game_timer[game_timer_data.seconds] = _seconds;
	global.game_timer[game_timer_data.minutes] = _minutes;
	global.game_timer[game_timer_data.hours] = _hours;
}

/// @function game_timer_pause
/// @param {Boolean} _pause = true
function game_timer_pause(_pause = true)
{
	global.game_timer[game_timer_data.pause] = _pause;
}

/// @function game_timer_reset
function game_timer_reset()
{
	global.game_timer[game_timer_data.ticks] = 0;
	global.game_timer[game_timer_data.seconds] = 0;
	global.game_timer[game_timer_data.minutes] = 0;
	global.game_timer[game_timer_data.hours] = 0;
}

/// @function game_timer_draw
/// @param _x
/// @param _y
function game_timer_draw(_x, _y)
{
	var _string = string_format(global.game_timer[game_timer_data.hours], 2, 0) + ":" + string_format(global.game_timer[game_timer_data.minutes], 2, 0) + ":" + string_format(global.game_timer[game_timer_data.seconds], 2, 0) + ":" + string_format(global.game_timer[game_timer_data.ticks], 2, 0);
	
	_string = string_replace_all(_string, " ", "0");
	draw_text(_x, _y, _string);
	
	gml_pragma("forceinline");
}


/// @function yorbs_add
/// @param {Real} _amount = 1
function yorbs_add(_amount = 1)
{
    var _turbo = global.turbo.mode;
    
	switch (global.story_mode)
	{
		case story_modes.super_freaks:
            if (!_turbo)
            {
    			global.heart_meter += _amount;
    	
    			if (global.heart_meter > 99)
    			{
    				if (global.hearts == hearts_maximum_get())
    					global.heart_meter = 99;
    				else
    				{
    					global.hearts++;
    					global.heart_meter = global.heart_meter mod 100;
    					sfx_play_global(sfx_heart);
    				}
    			}
            }
			break;
		default:
			player_meter_collect(2 * _amount);
			break;
	}
	
	sfx_play_global(sfx_yorb);
    
    if (_turbo)
        turbo_time_add(max(0.1, 0.3 * _amount));
    
    with (obj_gameplay_manager) 
        yorb_effect = min(yorb_effect + _amount, 7);
	
	gml_pragma("forceinline");
}

/// @function turbo_time_add
/// @param {Real} _amount = 1
function turbo_time_add(_amount = 1)
{
    global.turbo.time = min(global.turbo.time + _amount, TURBO_TIME_MAX);
    
    with (obj_gameplay_manager) 
        yorb_effect = min(yorb_effect + _amount, 7);
}

/// @function turbo_time_hit
function turbo_time_hit()
{
    if (instance_exists(obj_gameplay_manager) && obj_gameplay_manager.heart_shake == 0)
    {
        obj_gameplay_manager.heart_shake = 24;
        global.turbo.time -= global.turbo.punish * 5;
        global.turbo.punish++;
    }
}

/// @function yorb_collect_effect_multi
/// @param _x = x
/// @param _y = y
/// @param _value = 0
/// @param _index = round(random(6))
function yorb_collect_effect_multi(_x = x, _y = y, _value = 0, _index = round(random(6)))
{
	var _effect = instance_create_layer(_x, _y, "layer_instances", obj_yorb_collected_multi);
	
	with (_effect)
	{
		value = _value;
		image_index = _index;
	}
}