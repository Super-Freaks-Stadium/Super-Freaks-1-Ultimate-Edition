/// @description 

if (blink)
	gpu_set_fog(1, c_red, 0, 0);
draw_sprite_interpolated(sprite_index, image_index, x, y,,, face, 1,,, 0,, c_white, 1, global.delta);
if (blink)
	gpu_set_fog(0, c_white, 0, 0);