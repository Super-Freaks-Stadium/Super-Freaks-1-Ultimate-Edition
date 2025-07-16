/// @description Init

enum MENU_STATES
{
	CLOSED = 0,
	OPENING,
	OPEN,
	CLOSING,
}

// Inherit the parent event
event_inherited();

/// @function menu
function menu() constructor
{
	pages = {};
}

/// @function menu_page
function menu_page() constructor
{
	x = 0;
	y = 0;
	
	option = 
	{
		x: 0,
		y: 0,
		current: "",
		selected: false,
		list: {}, //all options get added to this list
	};
	
	/// @function update
	static update = function() //All options in the option.list would get stepped through
	{
		var _list = struct_get_names(option.list),
			_list_pos,
			_option;
			
		for (_list_pos = 0; _list_pos < array_length(_list); ++_list_pos)
		{
			_option = _list[_list_pos];
		}
	}
};

/// @function menu_option
function menu_option() constructor
{
	x = 0;
	y = 0;
	unlocked = function() {};
	selectable_area = 
	{
		x1: 0,
		y1: 0,
		x2: 0,
		y2: 0,
	};
	functions = 
	{
		focused: function() {},
		unfocused: function() {},
		pressed: function() {},
		hover: function() {},
		unhover: function() {},
	};
	neighbors = 
	{
		left: undefined,
		up: undefined,
		right: undefined,
		down: undefined,
	};
	
	/// @function update
	static update = function()
	{
		
	}
}


my_menu = new menu();
with (my_menu)
{
	pages = 
	{
		main: new menu_page(),
		story: 
		{
			select: new menu_page(),
			main: new menu_page(),
			challenge: new menu_page(),
			speedrun: new menu_page(),
		},
		options:
		{
			main: new menu_page(),
			visual: new menu_page(),
			audio: new menu_page(),
		},
		museum:
		{
			main: new menu_page(),
			bios: new menu_page(),
			theater: new menu_page(),
		},
	};
}

with (my_menu.pages.main)
{
	story = new menu_option();
	museum = new menu_option();
	options = new menu_option();
	website = new menu_option();
	exit_game = new menu_option();
}

with (my_menu.pages.story.select) //all of these options will take you to story.main but change the global.story_mode setting
{
	superfreaks = new menu_option();
	badguys = new menu_option();
	swordsman = new menu_option();
	antifreaks = new menu_option();
	final = new menu_option(); //opens character select and sends you straight to Apex--this is the only way to enter his level
}

with (my_menu.pages.story.main)
{
	adventure = new menu_option();
	challenge = new menu_option();
}

with (my_menu.pages.story.challenge)
{
    shuffle = new menu_option();
	speedrun = new menu_option();
	boss = new menu_option();
}

with (my_menu.pages.story.speedrun)
{
	normal = new menu_option();
	crazy = new menu_option();
	ludicrous = new menu_option();
	insane = new menu_option();
	freaky = new menu_option();
	kranion = new menu_option();
	mystic = new menu_option();
	adventure = new menu_option(); //all mandatory levels
	secret = new menu_option(); //all secret levels + secret weapon + encore + anti freaks
	ultimate = new menu_option(); //all levels
}

with (my_menu.pages.options.main)
{
	visual = new menu_option(); //go to my_menu.pages.options.visual
	audio = new menu_option(); //go to my_menu.pages.options.audio
	controls = new menu_option(); //open controls menu (this is a separate menu object and can also be opened from pause menu)
}

with (my_menu.pages.options.visual)
{
	aspect_ratio = new menu_option();
	upscale_screen = new menu_option();
	upscale_window = new menu_option();
	fullscreen = new menu_option();
	framerate = new menu_option();
	motion_sickness = new menu_option();
}

with (my_menu.pages.options.audio)
{
	volume_music = new menu_option();
	volume_sfx = new menu_option();
}

with (my_menu.pages.museum.main)
{
	bios = new menu_option(); //go to my_menu.pages.museum.bios
	theater = new menu_option(); //go to my_menu.pages.museum.theater
}