/// @description 

var _frame_delta = global.delta;

draw_sprite_interpolated(spr_rotato_spikeball, 0, x + spikeball[0][0].x_offset, y + spikeball[0][0].y_offset, x_previous + spikeball[0][1], y_previous + spikeball[0][2],,,,,,,,, _frame_delta);
draw_sprite_interpolated(spr_rotato_spikeball, 0, x + spikeball[1][0].x_offset, y + spikeball[1][0].y_offset, x_previous + spikeball[1][1], y_previous + spikeball[1][2],,,,,,,,, _frame_delta);
draw_sprite_interpolated(sprite_index, image_index, x, y,,, face, 1,,, 0,, c_white, 1, _frame_delta);