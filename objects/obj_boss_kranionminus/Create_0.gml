/// @description 

// Inherit the parent event
event_inherited();

depth = 201;
image_xscale = 4;
image_yscale = 4;

enum boss_kranionminus_states
{
	intro = 0,
    normal,
}
state_next_set(boss_kranionminus_states.intro);