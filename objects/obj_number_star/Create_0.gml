/// @description Init

var _i = 0;
var _hitbox_x, _hitbox_y;
var _despawn_x1 = 0, _despawn_y1 = 0, _despawn_x2 = 0, _despawn_y2 = 0;

event_inherited();

sfx = sfx_collect;
pitch = 1 - 0.125;
stars = array_create(path_get_number(path));
fast_forward = false;

for (_i = 0; _i < array_length(stars); ++_i)
{
	_hitbox_x = path_get_point_x(path, _i) - x;
	_hitbox_y = path_get_point_y(path, _i) - y;
	_despawn_x1 = min(_despawn_x1, _hitbox_x - 32);
	_despawn_y1 = min(_despawn_y1, _hitbox_y - 32);
	_despawn_x2 = max(_despawn_x2, _hitbox_x + 32);
	_despawn_y2 = max(_despawn_y2, _hitbox_y + 32);
	stars[_i] = [_hitbox_x, _hitbox_y, new comp_hitbox_AABB(_hitbox_x, _hitbox_y,, _i,, -32, -32, 32, 32)];
}

star_current = 0;

despawn_area[0] = _despawn_x1;
despawn_area[1] = _despawn_y1;
despawn_area[2] = _despawn_x2;
despawn_area[3] = _despawn_y2;

animate_previous = 0;
animate = 0;
animate_speed = 8;

my_method = method(id, function(){show_debug_message("bruh")});
depth = 4;