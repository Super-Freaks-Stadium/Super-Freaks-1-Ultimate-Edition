enum menu_option_data
{
	text = 0,
	func,
	unlocked,
	back_out,
}

/// @function menu_option_add
/// @description Adds an option to a menu as part of a 2D options array
/// @param _page
/// @param _index
/// @param {String} _text = ""
/// @param {Function} _function = function(){}
/// @param {Boolean} _unlocked = true
function menu_option_add(_page, _index, _text = "", _function = function(){}, _unlocked = true)
{
	options[_page][_index][menu_option_data.text] = _text;
	options[_page][_index][menu_option_data.func] = _function;
	options[_page][_index][menu_option_data.unlocked] = _unlocked;
}

/// @function menu_step
/// @description The basic menu step function
/// @param _player_number = 0
function menu_step(_player_number = 0)
{
	var _option_current, _option_func;
	
	_option_current = options[page][option];
	
	if not (options[page][option][menu_option_data.unlocked])
        input_verb_consume("confirm", global.player_lead);
    
    _option_func = _option_current[menu_option_data.func];
	
    _option_func();
	//}
}

/// @function menu_draw_default
/// @param _x = 0
/// @param _y = 0
function menu_draw_default(_x = 0, _y = 0)
{
	var _string = "";
	var _arrow = string("->");
	var _option_num;
	var _option_current;
	var _option_text;
	var _unlocked;
	//var _font_size = font_get_size(draw_get_font()) + _spacing;
	//var _text_x = _x + (string_length(_arrow) * _font_size);
	
	for (_option_num = 0; _option_num < array_length(options[page]); ++_option_num)
	{
		_option_current = options[page][_option_num];
		_unlocked = options[page][_option_num][menu_option_data.unlocked];
		
		if (_unlocked)
		{
			if (draw_get_color() != c_white)
				draw_set_color(c_white);
		}
		else
		{
			if (draw_get_color() != c_black)
				draw_set_color(c_black);
		}
		
		if (option == _option_num)
			_option_text = _arrow + _option_current[menu_option_data.text];
		else
			_option_text = _option_current[menu_option_data.text];
			
		//draw_text(_text_x, _y + (_option_num * _font_size), string(_option_text));
		_string = string_insert("\n" + string(_option_text), _string, string_length(_string) + 1);
	}
	
	draw_text(_x, _y, _string);
	
	//_option_num = option;
	//draw_text(_x, _y + (_option_num * _font_size), _arrow);
}
