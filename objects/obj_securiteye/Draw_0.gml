/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _angle = lerp(angle_previous, angle, _frame_delta);
var _triangle_x1 = searchlight.shape_x1;
var _triangle_y1 = searchlight.shape_y1;
var _triangle_v1  = new vector2(_triangle_x1, _triangle_y1).rotated(degtorad(angle_difference(angle_previous, angle) * _frame_delta)).add(new vector2(_x, _y));
var _triangle_x2 = searchlight.shape_x2;
var _triangle_y2 = searchlight.shape_y2;
var _triangle_v2  = new vector2(_triangle_x2, _triangle_y2).rotated(degtorad(angle_difference(angle_previous, angle) * _frame_delta)).add(new vector2(_x, _y));
var _triangle_x3 = searchlight.shape_x3;
var _triangle_y3 = searchlight.shape_y3;
var _triangle_v3  = new vector2(_triangle_x3, _triangle_y3).rotated(degtorad(angle_difference(angle_previous, angle) * _frame_delta)).add(new vector2(_x, _y));

if (!trigger_get(trigger_id))
{
	draw_sprite_ext(spr_securiteye, image_index, _x, _y, 1, 1, _angle, c_white, 1);
	draw_set_color(c_blue);
	draw_set_alpha(0.5);
	draw_triangle(_triangle_v1.x, _triangle_v1.y, _triangle_v2.x, _triangle_v2.y, _triangle_v3.x, _triangle_v3.y, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
else
	draw_sprite_ext(spr_securiteye_shut, image_index, _x, _y, 1, 1, _angle, c_white, 1);