/// @description 

var _i, _card_count;
var _card_image = 0;
var _extend = lerp(card_extend_previous, card_extend, global.delta);

for (_i = 0; _i < array_length(card_direction); ++_i)
{
	switch (card_direction[_i])
	{
		case "Left": //Left
			for (_card_count = card_amount; _card_count > 0; --_card_count)
			{
				draw_sprite(spr_platform_card, _card_image, x - (64 * _card_count) * _extend, y);
				_card_image++;
			}
			break;
		case "Up": //Up
			for (_card_count = card_amount; _card_count > 0; --_card_count)
			{
				draw_sprite(spr_platform_card, _card_image, x, y - (96 * _card_count) * _extend);
				_card_image++;
			}
			break;
		case "Right": //Right
			for (_card_count = 1; _card_count <= card_amount; ++_card_count)
			{
				draw_sprite(spr_platform_card, _card_image, x + (64 * _card_count) * _extend, y);
				_card_image++;
			}
			break;
		case "Down": //Down
			for (_card_count = 1; _card_count <= card_amount; ++_card_count)
			{
				draw_sprite(spr_platform_card, _card_image, x, y + (96 * _card_count) * _extend);
				_card_image++;
			}
			break;
	}
}

draw_sprite(spr_platform_card, _card_image, x, y);