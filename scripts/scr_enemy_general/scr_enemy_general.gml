enum enemy_hitbox_behaviors
{
	normal = 0,
	heavy,
	heavy_360,
	heavy_invulnerable,
	hazard,
	heavy_hazard,
	kill_player,
	die,
	bouncy,
}

/// @function hp_init
/// @param _hp = 1
function hp_init(_hp = 1)
{
	hp_start = _hp;
	hp = _hp;
	
	gml_pragma("forceinline");
}

/// @function enemy_hurt
/// @param _hp = 1
/// @param _hurt_timer = 8
function enemy_hurt(_hp = 1, _hurt_timer = 8)
{
	hp = max(hp - _hp, 0);
	hurt_timer_set(_hurt_timer);
	sfx_play_local(sfx_hit);
	hit_counter++;
	if (hp == 0)
		event_user(5);
	else
		event_user(6);
}

/// @function enemy_killed_create
/// @param _sprite_index = sprite_index
/// @param _image_index = image_index
/// @param _animate_speed = 0
/// @param _image_xscale = image_xscale
/// @param _image_yscale = image_yscale
/// @param _angle = 0
/// @param _speed_h = 0
/// @param _speed_v = -2
function enemy_killed_create(_sprite_index = sprite_index, _image_index = image_index, _animate_speed = 0, _image_xscale = abs(image_xscale) * face, _image_yscale = image_yscale, _angle = 0, _speed_h = 0, _speed_v = -2)
{
	with (instance_create(obj_enemy_killed, x, y))
	{
		sprite_index = _sprite_index;
		image_index = _image_index;
		animate_speed = _animate_speed;
		image_xscale = _image_xscale;
		image_yscale = _image_yscale;
        angle_previous = _angle;
		angle = _angle;
		speed_h = _speed_h;
		speed_v = _speed_v;
	}
}
