/// @description 

var _frame_delta = global.delta;

draw_sprite_interpolated(sprite_index,,,,,, image_xscale, image_yscale,,,,,, alpha, _frame_delta);

if (alpha == 1 && flash_effect > 0)
{
	draw_set_color(c_white);
	draw_set_alpha(flash_effect);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_alpha(1);
}