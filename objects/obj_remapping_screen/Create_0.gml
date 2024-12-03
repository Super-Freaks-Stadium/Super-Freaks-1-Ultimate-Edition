/// @description Init

var _i;

enum menu_remapping_screen_pages
{
	main = 0,
	remap,
}

// Inherit the parent event
event_inherited();

y_offset_previous = 1;
y_offset = 1;

player_number = 0;
page = menu_remapping_screen_pages.main;
option = 0;
options_max_on_screen = 9;

pause = false;

verb_index = 0;
set_all = false;
verb_list = 
[
	["Left", "left"],
	["Right", "right"], 
	["Up", "up"], 
	["Down", "down"],
	["Jump", "jump"],
	["Bubble", "bubble"],
	["Elastiband Toggle", "rubberband"],
	["Elastiband Color", "rubberband_color"],
	["Drop Out", "drop_out"],
	["Start", "start"],
	["Confirm", "confirm"],
	["Deny", "deny"]
];

for (_i = 0; _i < array_length(verb_list); ++_i)
{
	menu_option_add(menu_remapping_screen_pages.main, _i, verb_list[_i][0], function()
	{
		if (input_check_pressed("confirm", player_number))
		{
			verb_index = option;
		
			page = menu_remapping_screen_pages.remap;
			option = 0;
			set_all = false;
		}
	});
}

menu_option_add(menu_remapping_screen_pages.main, _i, "Set All", function()
{
	if (input_check_pressed("confirm", player_number))
	{
		verb_index = 0;
		
		page = menu_remapping_screen_pages.remap;
		option = 0;
		set_all = true;
	}
});

++_i;
menu_option_add(menu_remapping_screen_pages.main, _i, "Reset to Default", function()
{
	if (input_check_pressed("confirm", player_number))
	{
		sfx_play_global(sfx_ding);
		
		input_profile_reset_bindings("keyboard_and_mouse", player_number);
		input_profile_reset_bindings("gamepad", player_number);
		string_save(input_system_export(), "input.settings");
	}
});

depth = -9999;