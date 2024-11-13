/// @description 

var _i;
var _rotate_alpha = lerp(rotate_effect_previous, rotate_effect, frame_delta_level_get());
var _star_x, _star_y, _star_angle;
var _radius = hitbox.radius;

for (_i = 0; _i < 8; ++_i)
{
	_star_angle = _rotate_alpha + (_i * (360 / 8));
	_star_x = x + lengthdir_x(_radius, _star_angle);
	_star_y = y + lengthdir_y(_radius, _star_angle);
	draw_sprite(sprite_index, 1, _star_x, _star_y);
}

draw_sprite_interpolated(sprite_index, 0,,,,,scale_effect,scale_effect,scale_effect_previous,scale_effect_previous, image_angle, image_angle);
