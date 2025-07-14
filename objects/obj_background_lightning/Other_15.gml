/// @description Draw Background

var _view_x1 = view_x1_get();
var _scroll_delta = lerp(scroll_previous, scroll, global.delta);
var _view_height = view_height_get();

draw_set_color(make_colour_rgb(56, 0, 63));
draw_rectangle(0, 0, surface_get_width(surface), surface_get_height(surface), false);
draw_set_color(c_white);

draw_sprite_parallax_x(spr_background_lightning_clouds,, _view_x1, _view_height - 512, 2, -_scroll_delta);
draw_sprite_parallax_x(spr_background_lightning_clouds,, _view_x1, _view_height - 608, 1.5, -_scroll_delta * 3);
draw_sprite_parallax_x(spr_background_lightning_clouds,, _view_x1, _view_height - 704, 1, -_scroll_delta * 5);
draw_sprite_parallax_x(spr_background_lightning_mountains_back,, _view_x1, _view_height, 2);
draw_sprite_parallax_x(spr_background_lightning_mountains_front,, _view_x1, _view_height, 1.5);