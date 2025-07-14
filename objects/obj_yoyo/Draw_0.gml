/// @description 

var _hitbox_x, _hitbox_y, _hitbox_x_previous, _hitbox_y_previous;

_hitbox_x = x + hitbox.x_offset;
_hitbox_y = y + hitbox.y_offset;
_hitbox_x_previous = x + hitbox_x_offset_previous;
_hitbox_y_previous = y + hitbox_y_offset_previous;

draw_set_color(c_yellow);
draw_line_width(x, y, _hitbox_x, _hitbox_y, 2);
draw_set_color(c_white);
draw_sprite(sprite_index, 1, x, y);
draw_sprite_interpolated(sprite_index, 0, _hitbox_x, _hitbox_y, _hitbox_x_previous, _hitbox_y_previous,,,,, spin_angle, spin_angle_previous,,, global.delta);