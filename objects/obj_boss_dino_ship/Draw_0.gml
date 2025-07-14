/// @description Init

var _i;
var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _saber_x, _saber_y, _saber_angle = lerp_360(saber_angle_previous, saber_angle, _frame_delta);

draw_sprite(cockpit_sprite, cockpit_index, _x, _y);

for (_i = 0; _i < array_length(hitbox_saber); ++_i)
{
	if (hitbox_saber[_i].active != hitbox_active.inactive)
	{
		_saber_x = _x + hitbox_saber[_i].x_offset;
		_saber_y = _y + hitbox_saber[_i].y_offset;
		draw_sprite_ext(spr_boss_dino_saber, 0, _saber_x, _saber_y, 1, 1, _saber_angle + (_i * 90), c_white, 1);
	}
}