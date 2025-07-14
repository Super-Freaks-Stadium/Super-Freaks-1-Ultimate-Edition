/// @description 

var _y = lerp(y_start_frame, y, global.delta);
var _mirror = mirror_flip_get();

if (value == 0)
{
	draw_sprite_ext(spr_yorb, image_index, x, _y, 1, 1, 0, c_white, alpha);
}
else
{
	draw_set_font(global.font_12);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x + (16 * _mirror), _y, value, _mirror, 1, 0);
	draw_sprite(spr_yorb, image_index, x - ((string_width(value) / 2) * _mirror), _y);
}