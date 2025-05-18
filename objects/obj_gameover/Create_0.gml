/// @description 

// Inherit the parent event
event_inherited();

animate = 0;
depth = -9998;
state_next_set(0);
game_timer_pause(true);
music_stop();
music_set(MUSIC_NA);
audio_stop_all();
audio_play_sound_on(global.audio_emitter_music, choose(msc_gameover, msc_gameover, msc_gameover, msc_gameover_classic), false, 0);
//sfx_play_global(msc_gameover);
global.frame_machine_level.pause = true;
global.frame_machine_player.pause = true;