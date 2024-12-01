enum aspect_ratio_data
{
	width = 0,
	height,
	name,
}

/// @function aspect_ratio_list_init
function aspect_ratio_list_init()
{
	global.aspect_ratio_list = [];
		
	aspect_ratio_add(640, 360, "16:9 - 640 * 360"); // 16:9
	aspect_ratio_add(640, 400, "16:10 - 640 * 400"); // 16:10
	aspect_ratio_add(640, 480, "4:3 - 640 * 480"); // 4:3
	aspect_ratio_add(840, 360, "21:9 - 840 * 360"); // 21:9
	aspect_ratio_add(840, 400, "21:10 - 840 * 400"); // 21:10
	aspect_ratio_add(840, 480, "7:4 - 840 * 480"); // 7:4
    aspect_ratio_add(756, 360, "MOBILE DEBUG")
}

/// @function aspect_ratio_current_set
/// @param {int} _index
function aspect_ratio_current_set(_index)
{
	global.visuals_settings.aspect_ratio = _index;
	screen_set();
}

/// @function aspect_ratio_current_get
function aspect_ratio_current_get()
{
	return global.visuals_settings.aspect_ratio;
}

/// @function aspect_ratio_add
/// @param {int} _width
/// @param {int} _height
/// @param {String} _name = ""
function aspect_ratio_add(_width, _height, _name = "")
{
	var _list = global.aspect_ratio_list;
	
	array_push(_list, [_width, _height, _name]);
}
