/// @description Step

if (!ground_on)
{
	speed_v = min(speed_v + speed_grv, 6);
	
	y += speed_v;
	
	if (collision_down_simple())
	{
		ground_on = true;
		speed_v = 0;
	}
}

timer++;

if (timer > 80)
	image_index = 1;
	
if (timer == 192)
{
	timer++;
	level_beat();
	if (global.game_mode != game_modes.boss_rush && global.game_mode != game_modes.speedrun)
	{
		music_stop();
		music_set(MUSIC_NA);
		audio_stop_all();
		audio_play_sound_on(global.audio_emitter_music, msc_victory_kranion, false, 0);
	}
}