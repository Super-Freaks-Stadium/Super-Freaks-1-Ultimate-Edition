/// @function debug_init
/// @param {Boolean} _flag = false
function debug_init(_flag = false)
{
    if file_exists("debug")
    {
        global.debug = true;
        global.debug_startup = true;
    }
    else
    {
	    global.debug = _flag;
        global.debug_startup = _flag;
    }
	global.debug_viewer = array_create(4, false);
}