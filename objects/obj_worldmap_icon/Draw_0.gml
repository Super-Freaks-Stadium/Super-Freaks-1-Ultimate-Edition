/// @description 

var _x	 = x,
	_y	 = y,
	_img = level_id;

draw_self();

if (pic_alpha > 0)
{
	switch (x > (room_width / 2))
	{
		case true:
			_x = x - 112;
			break;
		case false:
			_x = x + 112;
			break;
	}
	_x = clamp(_x, 64, room_width - 64);
	_y = clamp(_y, 98, room_height - 98);
	
	if (level_id == level_ids.level_ludicrous_boss)
	{
		switch (global.story_mode)
		{
			case story_modes.kranion:
				_img = 15;
			break;
			case story_modes.swordsman:
				_img = 31;
			break;
		}
	}
	
	if (level_id == level_ids.level_kranion_final_boss)
	{
		switch (global.story_mode)
		{
			case story_modes.kranion:
				_img = 32;
			break;
			case story_modes.swordsman:
				_img = 33;
			break;
		}
	}
	
	draw_sprite_ext(spr_worldmap_pictures, _img, _x, _y, 1, 1, 0, c_white, pic_alpha);
}