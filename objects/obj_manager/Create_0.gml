/// @description Init Game

var _binding_string;

if (instance_number(object_index) > 1)
{
    __input_error("More than one instance of ", object_get_name(object_index), " has been created\nPlease ensure that ", object_get_name(object_index), " is never manually created");
    instance_destroy();
    return;
}

global.demo = false;
input_join_params_set(1, 4, undefined, undefined, false);
if (file_exists("input.settings"))
{
	_binding_string = string_load("input.settings");
	if input_system_verify(_binding_string)
		input_system_import(_binding_string);
}
input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
global.input_source_mode_previous = INPUT_SOURCE_MODE.FIXED;
randomize();

#region Init Components
	comp_list_camera_init();
#endregion

audio_init();
debug_init(true);
framerate_game_init();
gameplay_init();
room_transition_init();
visuals_init();
//virtual_buttons_init();

instance_create(obj_menu_pause, 0, 0);
instance_create(obj_metronome, 0, 0);

global.animate = 0;
global.game_frame_new = true;
global.instance_despawn_timer = 8;

global.hearts = 0;
global.heart_meter = 0;

global.water_active = true;
global.water_height = 256;

global.frame = 0;
global.delta = 1;

global.story_mode = story_modes.super_freaks;

gc_timer = 0;
gc_enable(false);
depth = __INPUT_CONTROLLER_OBJECT_DEPTH;

//show_debug_overlay(true);
