/// @description Init

// Inherit the parent event
event_inherited();

camera = new comp_camera(room_width / 2, room_height / 2);
depth = -5;
sfx_play_global(sfx_title_voice);

//gml_pragma("UnityBuild", "true");