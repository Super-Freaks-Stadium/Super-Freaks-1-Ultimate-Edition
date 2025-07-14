/// @description 

var _y_delta = lerp(y_start_frame, y, global.delta);

//draw_set_color(c_purple);
draw_sprite_stretched(spr_star_floor_rising, 0, x - 1000, _y_delta - 16, x + 1000, 32);
//draw_rectangle(x - 1000, y, x + 1000, y + 1000, false);