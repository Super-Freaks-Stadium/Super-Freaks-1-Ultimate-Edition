#macro EVENT_INIT event_perform(ev_create, 0)
#macro EVENT_CLEAN event_perform(ev_cleanup, 0)
#macro EVENT_STEP event_user(0)
#macro EVENT_STEP_2 event_user(1)
#macro EVENT_SPAWN event_user(2)
#macro EVENT_DESPAWN event_user(3)
#macro EVENT_FRAMEBEGIN event_user(4)

/// @function instance_create
/// @param _object_index
/// @param _x = x
/// @param _y = y
function instance_create(_object_index, _x = x, _y = y)
{
	return instance_create_layer(_x, _y, "layer_instances", _object_index);
	
	gml_pragma("forceinline");
}

/// @function instance_step
function instance_step()
{
	run_frame = true;
	state_machine_step();
	collider_attach_step();
	EVENT_STEP;
	if (is_undefined(collider_attach[collider_attach_data.collider]))
		comp_list_collider_move();
	image_index += animate_speed;
}

/// @function instance_step_2
function instance_step_2()
{
	EVENT_STEP_2;
}

/// @function instance_frame_begin
function instance_frame_begin()
{
	EVENT_FRAMEBEGIN;
}

/// @function instance_spawn
function instance_spawn()
{
	EVENT_SPAWN;
	comp_list_hitbox_update(true);
	comp_list_collider_spawn();
	x_previous = x;
	y_previous = y;
	x_start_frame = x;
	y_start_frame = y;
	//show_debug_message("SPAWN " + string(object_get_name(object_index)) + " " + string(id));
}

/// @function instance_despawn
function instance_despawn()
{
	EVENT_DESPAWN;
	collider_attach_clear();
	hashmap_cells_remove_from();
	
	switch (zone_index)
	{
		case -3:
		case undefined:
			instance_destroy();
			break;
		case -2:
			instance_deactivate_object(self);
			break;
		default:
			if (is_undefined(instance_num))
			{
				instance_destroy();
				//show_debug_message("DESTROY " + string(object_get_name(object_index)) + " " + string(id));
			}
			else
			{
				global.instance_spawn_list[instance_num][zone_instance_data.can_spawn] = true;
				//show_debug_message("DESPAWN " + string(object_get_name(object_index)) + " " + string(id));
				instance_deactivate_object(self);
			}
			break;
	}
}

/// @function instance_despawn_check
function instance_despawn_check()
{
	var _view_x1, _view_y1, _view_x2, _view_y2;
	var _my_x1, _my_y1, _my_x2, _my_y2;
	var _despawn = true;
	
	if (zone_index == -2 || can_despawn == false)
		exit;
		
	_my_x1 = x + despawn_area[0];
	_my_y1 = y + despawn_area[1];
	_my_x2 = x + despawn_area[2];
	_my_y2 = y + despawn_area[3];
	
	with (global.view)
	{
		_view_x1 = spawn_area[0] - 64;
		_view_y1 = spawn_area[1] - 64;
		_view_x2 = spawn_area[2] + 64;
		_view_y2 = spawn_area[3] + 64;
	}
		
	if (rectangle_in_rectangle(_my_x1, _my_y1, _my_x2, _my_y2, _view_x1, _view_y1, _view_x2, _view_y2))
		_despawn = false;
	
	switch (zone_index)
	{
		case -3:
		case undefined:
			if (_despawn)
				instance_despawn();
			break;
		case -2:
			exit;
			break;
		case -1:
			if (_despawn)
				instance_despawn();
			break;
		default:
			if (_despawn == false)
				global.zones[zone_index][zone_data.active] = true;
			else
			{
				if (global.zones[zone_index][zone_data.active] == false)
					instance_despawn();
			}
			break;
	}
}
