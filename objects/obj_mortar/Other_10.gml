/// @description Step

var _fireball, _shoot_direction;
var _zone = zone_index;

// Inherit the parent event
event_inherited();

switch (state)
{
	case enemy_mortar_states.ready:
		if (state_begin)
		{
			sprite_index = spr_mortar_stand;
			image_index = 0;
			timer = 0;
		}
		timer++;
		if (timer >= shoot_frequency)
			state_next_set(enemy_mortar_states.shoot_1);
		break;
	case enemy_mortar_states.shoot_1:
		if (state_begin)
		{
			sprite_index = spr_mortar_shoot;
			image_index = 0;
			timer = 0;
		}
		timer++;
		if (timer >= 32)
		{
			switch (face)
			{
				case -1:
					_shoot_direction = 180;
					break;
				default:
					_shoot_direction = 0;
					break;
			}
			if (in_view())
				sfx_play_local(sfx_explode_short);
			_fireball = instance_create_layer(x, y, "layer_instances", obj_enemy_fireball, 
			{
				speed: 3,
				direction: _shoot_direction,
				zone_index: _zone
			});
			_fireball = instance_create_layer(x, y - 24, "layer_instances", obj_enemy_fireball, 
			{
				speed: 3,
				direction: _shoot_direction,
				zone_index: _zone
			});
			_fireball = instance_create_layer(x, y + 24, "layer_instances", obj_enemy_fireball, 
			{
				speed: 3,
				direction: _shoot_direction,
				zone_index: _zone
			});
			state_next_set(enemy_mortar_states.shoot_2);
		}
		break;
	case enemy_mortar_states.shoot_2:
		if (state_begin)
		{
			sprite_index = spr_mortar_shoot;
			image_index = 1;
			timer = 0;
		}
		timer++;
		if (timer >= 16)
			state_next_set(enemy_mortar_states.ready);
		else if (timer >= 8)
			image_index = 2;
		break;
}

