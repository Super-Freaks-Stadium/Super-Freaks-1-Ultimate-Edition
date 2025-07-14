/// @description 

var _i = 0;
var _star_x, _star_y, _star_active;
var _animate = lerp_360(animate_previous, animate, global.delta);
var _star_angle = lengthdir_x(22.5, _animate);
var _number_angle = lengthdir_x(5, _animate);

draw_set_color(c_white);
draw_set_font(global.font_title);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (_i = 0; _i < array_length(stars); ++_i)
{
	_star_active = stars[_i][2].active;
	
	if (_star_active != hitbox_active.inactive)
	{
		_star_x = x + stars[_i][0];
		_star_y = y + stars[_i][1];
		
		if (in_view(_star_x - 32, _star_y - 32, _star_x + 32, _star_y + 32))
		{
			draw_sprite_interpolated(spr_number_star, 0, _star_x, _star_y, _star_x, _star_y,,,,, _star_angle, _star_angle);
			draw_text_transformed(_star_x, _star_y, string(_i + 1), mirror_flip_get(), 1, _number_angle);
		}
	}
}