/// @description Init

// Inherit the parent event
event_inherited();

hitbox = new comp_hitbox_circle(,,,,, 24 * abs(image_xscale));
animate_speed = 0.125;
if (in_view())
{
	audio_stop_sound(sfx_explode);
	sfx_play_local(sfx_explode);
}