/// @description Step

timer++;

if ((timer > 200 || input_check_pressed("confirm", global.player_lead)) && !room_transition_active_get())
{
	spawn_point_set(rm_cutscene_intro);
	instance_create_layer(0, 0, "layer_instances", obj_room_transition_fade);
}