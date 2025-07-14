/// @description 

var _list = instance_attach_list;
var _player_instance;
var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

draw_sprite(sprite_index, image_index, _x, _y);

if (array_length(_list) > 0)
{
	_player_instance = _list[0];
	if (instance_exists(_player_instance))
		draw_sprite(player_animation_get(_player_instance.character_index, player_animations.hud_face), 0, _x, _y - 48);
}