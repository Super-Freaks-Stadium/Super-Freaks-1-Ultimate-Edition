/// @description Draw Background

var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _scroll_delta = lerp(scroll_previous, scroll, global.delta);

draw_set_color(c_black);
draw_rectangle(0, 0, surface_get_width(surface), surface_get_height(surface), false);

draw_sprite_parallax(spr_castle_background_pillar, alternate, _view_x1, _view_y1, 2, 2, 0, _scroll_delta, 320, 0);
draw_set_color(c_white);