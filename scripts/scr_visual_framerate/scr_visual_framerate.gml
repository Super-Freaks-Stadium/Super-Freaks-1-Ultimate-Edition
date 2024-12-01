/// @function framerate_list_init
function framerate_list_init()
{
	global.framerate_list = [];
		
	framerate_add(infinity);
	framerate_add(30);
	framerate_add(60);
	framerate_add(90);
	framerate_add(120);
	framerate_add(144);
	framerate_add(165);
	framerate_add(240);
}

/// @function framerate_add
/// @param {int} _framerate
function framerate_add(_framerate)
{
	var _list = global.framerate_list;
	
	array_push(_list, _framerate);
}

/// @function framerate_current_get
function framerate_current_get()
{
	return global.visuals_settings.frame_rate;
}