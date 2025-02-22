/// @description End

switch (global.game_mode)
{
    case game_modes.museum:
        spawn_point_set(rm_menu_main);
        instance_create_layer(0, 0, "layer_instances", obj_room_transition_fade);
        break;
    default:
        spawn_point_set(rm_title);
        instance_create_layer(0, 0, "layer_instances", obj_room_transition_fade);
        break;
}

music_stop();
