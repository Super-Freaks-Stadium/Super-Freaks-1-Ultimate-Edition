var _frame_delta = global.delta;

var _y = lerp(y_start_frame, y, _frame_delta);
var _y_offset = lerp(wartnose_visuals.y_offset_previous, wartnose_visuals.y_offset, _frame_delta);

var _cup,
	_cup_list = cups,
	_cup_list_length = array_length(_cup_list);
	
if (_y_offset > -128)
	draw_sprite_ext(sprite_index, 0, lerp(cups[0].x_previous, cups[0].x, _frame_delta), _y + _y_offset, wartnose_visuals.flip, 1, 0, c_white, 1);
for (_cup = 0; _cup < _cup_list_length; ++_cup)
{
	with (cups[_cup])
		draw_sprite(spr_boss_wartnose_cup, 0, lerp(x_previous, x, _frame_delta), _y);
}