/// @description 

var _x_offset_delta = lerp(offset_x_previous, offset_x, global.delta);
var _y_offset_delta = lerp(offset_y_previous, offset_y, global.delta);

draw_sprite_tiled(spr_hippie_wind, image_index, _x_offset_delta, _y_offset_delta);