/// @description 

var _i;
var _frame_delta = global.delta;
var _x, _y, _x_previous, _y_previous, _x_delta, _y_delta;
var _size_delta = lerp(size_previous, size, _frame_delta);

for (_i = 0; _i < 1; _i += 0.125)
{
	_x = lerp(xstart, x, _i);
	_y = lerp(ystart, y, _i);
	_x_previous = lerp(xstart, x_start_frame, _i);
	_y_previous = lerp(ystart, y_start_frame, _i);
	_x_delta = lerp(_x_previous, _x, _frame_delta);
	_y_delta = lerp(_y_previous, _y, _frame_delta);
	draw_sprite(spr_chain, 0, _x_delta, _y_delta);
}

_x = x; 
_y = y;
_x_previous = x_start_frame;
_y_previous = y_start_frame;
_x_delta = lerp(_x_previous, _x, _frame_delta);
_y_delta = lerp(_y_previous, _y, _frame_delta);
draw_sprite_ext(sprite_index, image_index, _x_delta, _y_delta, _size_delta, _size_delta, 0, c_white, 1);