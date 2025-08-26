/// @description Step

var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;
var _face = sign(image_xscale);
var _drop_speed = drop_speed;
var _object;
var _zone = zone_index;

x += speed_h;
y += speed_v;

collision_flags = 0;

switch sign(x - x_previous)
{
	case -1:
		collision_left_simple();
		break;
	case 0:
	case 1:
		collision_right_simple();
		break;
}

_collision_left = collision_flag_get_left();
_collision_right = collision_flag_get_right();
		
if (_collision_left)
{
	if (speed_h < 0)
		speed_h = -speed_h;
}
if (_collision_right)
{
	if (speed_h > 0)
		speed_h = -speed_h;
}

timer++;
if (timer >= timer_frequency)
{
	switch (drop_type)
	{
		case "Barrel":
			_object = instance_create_layer(x, y + 32, "layer_instances", obj_crackerbarrel);
			with (_object)
			{
				face = _face;
				speed_initial = _drop_speed;
				//can_despawn = false;
				zone_index = _zone;
			}
			break;
		case "Barrel_Bounce":
			_object = instance_create_layer(x, y + 32, "layer_instances", obj_crackerbarrel,
			{
				bouncy: true,
			});
			with (_object)
			{				
				face = _face;
				speed_initial = _drop_speed;
				//can_despawn = false;
				zone_index = _zone;
			}
			break;
		case "Bomb":
			_object = instance_create_layer(x, y + 32, "layer_instances", obj_kranibomb);
			with (_object)
			{
				direction = 270;
				speed = _drop_speed;
				//can_despawn = false;
				zone_index = _zone;
			}
			break;
		case "Ball":
			_object = instance_create_layer(x, y + 32, "layer_instances", obj_crackerball);
			with (_object)
			{
				face = _face;
				speed_initial = _drop_speed;
				//can_despawn = false;
				zone_index = _zone;
			}
			break;
		default:
			break;
	}
	timer = 0;
    sprite_index = spr_fusedropper_orange;
}
else if (timer > timer_frequency - 28)
{
    sprite_index = spr_fusedropper_prepare;
}