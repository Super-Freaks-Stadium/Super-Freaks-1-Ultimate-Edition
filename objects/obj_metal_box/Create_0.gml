/// @description Init

var _my_id = id;
var _xscale = image_xscale;
var _yscale = image_yscale;
var _width = abs(_xscale * sprite_get_width(sprite_index));
var _height = abs(_yscale * sprite_get_height(sprite_index));
var _width_half = _width / 2;
var _height_half = _height / 2;
var _zone_index = zone_index;

// Inherit the parent event
event_inherited();

collider = new comp_collider_AABB(,, -_width / 2, -_height, _width / 2, 0);
with (collider)
{
	solid_x1 = collider_solidity.solid;
	solid_y1 = collider_solidity.solid;
	solid_x2 = collider_solidity.solid;
	solid_y2 = collider_solidity.solid;
}

despawn_area[0] = -_width_half;
despawn_area[1] = -_height;
despawn_area[2] = _width_half;
despawn_area[3] = 0;

ground_on = false;
speed_grv = 0.25;

collider_detector_sides_set(-_height + 8, -_height_half, -8, _height_half, _width_half);
collider_detector_up_set(-_width_half + 8, 0, _width_half - 8, 0, -_height);
collider_detector_down_set(-_width_half, 0, _width_half, 0, 0);

back_sprite_support = instance_create_layer(x, y, "layer_instances", obj_background_sprite_support);

with (back_sprite_support)
{
	owner = _my_id;
	zone_index = _zone_index;
	
	draw_func = function()
	{
		var _height, _x, _y, _frame_delta;
		if (!instance_exists(owner))
			exit;
			
		_height = abs(sprite_get_height(spr_metal_box) * owner.image_yscale);
		_frame_delta = global.delta;
		_x = lerp(owner.x_start_frame, owner.x, _frame_delta);
		_y = lerp(owner.y_start_frame, owner.y, _frame_delta);
		
		draw_sprite_ext(spr_metal_box_top, 0, _x, _y - _height, owner.image_xscale, 1, 0, c_white, 1);
	}
}