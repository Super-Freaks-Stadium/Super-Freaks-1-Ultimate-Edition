/// @description Init

// Inherit the parent event
event_inherited();

//text = "ALPHA 13\n7/23/2023\nBy SuperFreaksDev\nOriginal Game: 2006 - 2016";
text = "v3.0.3\n11/13/2024\nBy SuperFreaksDev/Joe Mama\nOriginal Game: 2006 - 2016";
camera = new comp_camera(room_width / 2, room_height / 2);
depth = -5;
sfx_play_global(sfx_title_voice);

//gml_pragma("UnityBuild", "true");