/// #function framerate_game_init
function framerate_game_init()
{
	framerate = 60;
	framerate_min = 10;
	framerate_delta = delta_time/1000000;
	
	frame_restored = false;
	frame_accumulator = 0;
	frame_amount = 0;
	
	global.frame_delta = 0;
	
	global.frame_machine_list = [];
	global.frame_machine_player = new frame_machine();
	global.frame_machine_level = new frame_machine();
}

/// @function framerate_game_step
function framerate_game_step()
{
	var _frame_delta_current;
	var _list, _list_pos, _frame_machine;
	
	var _frame_delta_temp, _frame_delta_max, _frame_delta_min;
	var _frame_next_delta = delta_time/1000000;
	
	_frame_delta_temp = framerate_delta;
	_frame_delta_min = 1/framerate_min;
	_frame_delta_max = 1/framerate;
		
	if (_frame_next_delta > _frame_delta_min)
	{
		if (frame_restored)
			framerate_delta = _frame_delta_min;
		frame_restored = true;
	}
	else	
		framerate_delta = _frame_next_delta;
	frame_restored = false;
	
	frame_accumulator += _frame_delta_temp;
	frame_amount = 0;
		
	if (frame_accumulator >= _frame_delta_max)
	{
		while (frame_accumulator >= _frame_delta_max)
		{
			frame_accumulator -= _frame_delta_max;
			++frame_amount;
		}
	}
	global.frame_delta = frame_accumulator / _frame_delta_max;
	_frame_delta_current = global.frame_delta;
	
	_list = global.frame_machine_list;
	for (_list_pos = 0; _list_pos < array_length(_list); ++_list_pos)
	{
		_frame_machine = _list[_list_pos];
		
		with (_frame_machine)
		{
			if (pause)
				continue;
				
			frame_delta = _frame_delta_current;
		}
	}
}

/// @function frame_machine
/// @param {float} _multiplier = 1
function frame_machine(_multiplier = 1) constructor
{
	var _my_id = self;
	
	multiplier = _multiplier;
	fast_forward = 0;
	pause = false;
	frame_counter = 0;
	frame_amount = 0;
	frame_amount_fast_forward = 0;
	frame_delta = delta_time/1000000;
	
	array_push(global.frame_machine_list, _my_id);
}

/// @function frame_machine_step
function frame_machine_step()
{
	var _list = global.frame_machine_list;
	var _list_pos;
	var _frame_machine;
	
	for (_list_pos = 0; _list_pos < array_length(_list); ++_list_pos)
	{
		_frame_machine = _list[_list_pos];
		
		with (_frame_machine)
		{
			frame_amount_fast_forward = 0;
			if (pause)
				continue;
				
			frame_counter += multiplier;
			while (frame_counter >= 1)
			{
				frame_amount += 1;
				frame_counter -= 1;
			}
			frame_amount_fast_forward = frame_amount;
			if (fast_forward > 0)
			{
				frame_counter += fast_forward;
				while (frame_counter >= 1)
				{
					frame_amount_fast_forward += 1;
					frame_counter -= 1;
				}
			}
		}
	}
}

/// @function fast_forward_level_get
function fast_forward_level_get()
{
	return global.frame_machine_level.fast_forward;
	
	gml_pragma("forceinline");
}

