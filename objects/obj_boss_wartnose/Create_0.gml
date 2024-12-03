/// @description Init

enum boss_wartnose_states
{
	intro = 0,
	lower,
	raise,
	shuffle,
	attack,
	death,
}

// Inherit the parent event
event_inherited();

boss_name = "Wartnose";
hp_init(8);
phase = 0;
can_despawn = false;

cup_positions = [608, 736, 864, 992];
array_shuffle(cup_positions);
cups = 
[
	{
        x_previous: cup_positions[0],
		x: cup_positions[0],
	},
	{
        x_previous: cup_positions[1],
		x: cup_positions[1],
	},
	{
        x_previous: cup_positions[2],
		x: cup_positions[2],
	},
	{
        x_previous: cup_positions[3],
		x: cup_positions[3],
	},
];

shuffles = 4;
timer = 0;
timer_enemy = 80;
state_next_set(boss_wartnose_states.intro);

/// @function shuffle_cups
shuffle_cups = function()
{
	var _array_new = [],
		_list_length = array_length(cups),
		_cup_1 = irandom_range(0, _list_length - 1),
		_cup_2 = (_cup_1 + irandom_range(1, _list_length - 2)) mod _list_length;
		
	array_copy(_array_new, 0, cup_positions, 0, _list_length);
	_array_new[_cup_1] = cup_positions[_cup_2];
	_array_new[_cup_2] = cup_positions[_cup_1];
	cup_positions = _array_new;
}

switch (global.difficulty)
{
	case difficulty_levels.easy:
		phase = 0;
		break;
	case difficulty_levels.normal:
		phase = 1;
		break;
	case difficulty_levels.hard:
		phase = 2;
		break;
}

switch (global.boss_phase)
{
	case 0:
		break;
	case 1:
		phase++;
		hp = 4;
		break;
	case 2:
		hp = 0;
		state_next_set(boss_wartnose_states.death);
		break;
}

timer_max = 48;

hide = false;
wartnose_visuals = 
{
    y_offset_previous: 0,
	y_offset: 0,
	flip: 1,
	flip_timer: 0,
}

hitbox = new comp_hitbox_AABB(,, hitbox_active.inactive, enemy_hitbox_behaviors.heavy,, -48, 0, 48, 128);