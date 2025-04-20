/// @description 

// Inherit the parent event
event_inherited();

depth = 250;
image_xscale = 4;
image_yscale = 4;

boss_name = "Kranion Minus";
hp_init(16);

locations_summon = 
[
	[512, 384],
	[512, 576],
	[512, 768],

	[864, 480],
	[864, 672],
	
	[1216, 384],
	[1216, 576],
	[1216, 768],
];
locations_summon = array_shuffle(locations_summon);
location_current = 0;

enum boss_kranionminus_states
{
	intro = 0,
    normal,
}
state_next_set(boss_kranionminus_states.intro);
hitbox.active = hitbox_active.inactive;