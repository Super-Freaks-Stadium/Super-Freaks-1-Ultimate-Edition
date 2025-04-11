/// @description 

var _view_x1 = view_x1_get();
var _view_x2 = view_x2_get();

draw_set_alpha(image_alpha);
switch (state)
{
	case 2:
		draw_set_color(c_red);
		break;
	default:
		draw_set_color(c_gray);
		break;
}
draw_line_width(_view_x1, y, _view_x2, y, (96 * multiplier));
draw_set_color(c_white);
draw_set_alpha(1);