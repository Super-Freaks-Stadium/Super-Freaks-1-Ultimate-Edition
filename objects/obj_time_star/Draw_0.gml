/// @description 

var _i = 0;
var _star_x, _star_y, _star_active;
var _animate = lerp_360(animate_previous, animate, frame_delta_level_get());
var _star_angle = lengthdir_x(22.5, _animate);

for (_i = 0; _i < array_length(stars); ++_i)
{
	_star_active = stars[_i][2].active;
	
	if (_star_active != hitbox_active.inactive)
	{
		_star_x = x + stars[_i][0];
		_star_y = y + stars[_i][1];
		
		if in_view(_star_x - 32, _star_y - 32, _star_x + 32, _star_y + 32)
		{
			draw_sprite_interpolated(spr_time_star, 0, _star_x, _star_y, _star_x, _star_y,,,,, _star_angle, _star_angle, c_white);
			draw_set_color(c_lime);
			draw_pie(_star_x, _star_y, timer, time, 24);
		}
	}
}

draw_set_color(c_white);