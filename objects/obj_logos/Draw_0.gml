/// @description 

var _center_x = room_width / 2;
var _center_y = room_height / 2;


if (timer > 2)
{
	draw_set_font(global.font_12);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_ext(_center_x, _center_y, "Thanks for playing Super Freaks 1 Ultimate Edition! This is the third major release of the game, adding the fast paced Uncle Swordsman Story. Stay tuned for 4.0, featuring even more stuff!\n- Mr. Freaks", -1, 424);
}