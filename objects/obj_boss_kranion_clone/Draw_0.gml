/// @description 

var _sprite_height = sprite_get_height(sprite_index),
	_sprite_height_half = _sprite_height / 2,
	_sprite_width_half = sprite_get_width(sprite_index) / 2,
	_sprite_cutoff = _sprite_height * teleport_timer,
	_sprite_cutoff_y = y - _sprite_height_half + _sprite_cutoff;

switch (state)
{
	case -1:
		break;
    case BOSS_KRANION_CLONE_STATES.INTRO:
        draw_sprite_general(sprite_index, image_index, 0, _sprite_cutoff, _sprite_height, 1, x - _sprite_width_half, 0, 1, _sprite_cutoff_y, 0, c_white, c_white, c_white, c_white, 1);
        draw_sprite_part(sprite_index, image_index, 0, _sprite_cutoff, _sprite_height, _sprite_height - _sprite_cutoff, x - _sprite_width_half, _sprite_cutoff_y);
        break;
    default:
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_xscale, 0, c_white, 1);
        break;
}