/// @description 

var _center_x = room_width / 2;
var _center_y = room_height / 2;
var _view_x1 = view_x1_get(),
    _view_y1 = view_y1_get(),
    _view_x2 = view_x2_get(),
    _view_y2 = view_y2_get();

draw_sprite(sprite_index, 0, x, y);

draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(_view_x1, _view_y2 - 32, _view_x2, _view_y2, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_set_font(global.font_16);
draw_verb(global.player_lead, "confirm", _center_x - 16, _view_y2 - 16);
draw_verb(global.player_lead, "start", _center_x + 16, _view_y2 - 16);

draw_set_valign(fa_bottom);
draw_set_font(global.font_12);
draw_set_halign(fa_left);
draw_text(_view_x1, _view_y2, "v3.1.1\n8/31/2025");
draw_set_halign(fa_right);
draw_text(_view_x2, _view_y2, "By Mr. Freaks\nMusic by philraco and SFD");