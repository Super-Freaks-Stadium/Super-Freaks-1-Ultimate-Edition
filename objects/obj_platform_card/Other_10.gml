/// @description Step

var _i;
var _card, _card_extend;

switch (state)
{
	case 0: //Delay
		if (state_begin)
		{
			card_extend = 0;
			delay_timer = 0;
		}
		delay_timer++;
		if (delay_timer >= card_delay)
			state_next_set(1);
		break;
	case 1: //Grow
		if (state_begin)
			delay_timer = 0;
			
		card_extend = min(card_extend + (card_speed / 100), 1);
		
		if (card_extend == 1)
			state_next_set(2);
		break;
	case 2: //Delay
		if (state_begin)
		{
			card_extend = 1;
			delay_timer = 0;
		}
		delay_timer++;
		if (delay_timer >= card_delay)
			state_next_set(3);
		break;
	case 3: //Shrink
		if (state_begin)
			delay_timer = 0;
			
		card_extend = max(card_extend - (card_speed / 100), 0);
		
		if (card_extend == 0)
			state_next_set(0);
		break;
}

_card_extend = card_extend;

for (_i = 0; _i < array_length(card_direction); ++_i)
{
	switch (card_direction[_i])
	{
		case "Left":
			collider_horizontal.shape_x1 = -32 - ((64 * card_amount + 1) * card_extend);
			break;
		case "Up":
			collider_vertical.shape_y1 = -48 - ((96 * card_amount + 1) * card_extend);
			break;
		case "Right":
			collider_horizontal.shape_x2 = 32 + ((64 * card_amount + 1) * card_extend);
			break;
		case "Down":
			collider_vertical.shape_y2 = 48 + ((96 * card_amount + 1) * card_extend);
			break;
	}
}