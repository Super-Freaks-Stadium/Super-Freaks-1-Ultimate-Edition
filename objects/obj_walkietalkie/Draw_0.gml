/// @description 

var _zoom = global.view.z;

var _x = x,
    _y = y - 32;
    
var _hint = hint,
    _hint_width = 320,
    _hint_width_half,
    _hint_height,
    _hint_index = 0;

var _depth_old = gpu_get_depth();

if (!surface_exists(global.surface_HUD))
	exit;

draw_sprite_interpolated(sprite_index);

if (alpha > 0)
{
	switch (global.story_mode)
	{
		case story_modes.kranion:
			if (hint_kranion != "")
				_hint = hint_kranion;
			break;
		case story_modes.swordsman:
			if (hint_swordsman != "")
				_hint = hint_swordsman;
			break;
		case story_modes.anti_freaks:
			if (hint_antifreaks != "")
				_hint = hint_antifreaks;
			_hint_index = 1;
			break;
		default:
			break;
	}
    
    draw_set_font(font_normal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    if (string_length(_hint) > 200)
        _hint_width = 424;
    
    _hint_width_half = _hint_width / 2;
    _hint_height = string_height_ext(_hint, -1, _hint_width);
    
    _x = clamp(x, view_x1_get() + 8 + _hint_width_half * _zoom, view_x2_get() - 8 - _hint_width_half * _zoom);
    if (down)
        _y += _hint_height + 72;
    
    _x -= view_x1_get();
    _y -= view_y1_get();
    _x /= _zoom;
    _y /= _zoom;
    
    if (mirror_flip_get() == -1)
        _x = screen_width_get() - _x;
    
    show_debug_message($"X: {_x}");
	
    surface_set_target(global.surface_HUD);
    
    draw_set_alpha(alpha * 0.8);
    draw_sprite_stretched(spr_textbox_uncle_swordsman, _hint_index, _x - 8 - _hint_width_half, _y - _hint_height, _hint_width + 16, _hint_height);
    draw_set_alpha(alpha);
    draw_text_ext(_x, _y, _hint, -1, _hint_width);
    if (down)
        draw_sprite_ext(spr_hint_head, _hint_index, _x, _y, 1, -1, 0, c_white, alpha);
    else
    	draw_sprite_ext(spr_hint_head, _hint_index, _x, _y - _hint_height, 1, 1, 0, c_white, alpha);
    
    draw_set_alpha(1);
    surface_reset_target();
}