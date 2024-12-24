/// @description 

if (!room_transition_active_get())
{
	instance_create(obj_level_win_explosion);
	sfx_play_local(sfx_explode);
	global.frame_machine_level.pause = true;
	global.frame_machine_player.pause = true;
	instance_destroy();
}
