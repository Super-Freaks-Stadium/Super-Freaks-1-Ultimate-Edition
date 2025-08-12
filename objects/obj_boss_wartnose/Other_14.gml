/// @description Frame Begin

var _cup, _cup_list_length = array_length(cups);

// Inherit the parent event
event_inherited();

wartnose_visuals.y_offset_previous = wartnose_visuals.y_offset;
for (_cup = 0; _cup < _cup_list_length; ++_cup)
{
	with (cups[_cup])
        x_previous = x;
}