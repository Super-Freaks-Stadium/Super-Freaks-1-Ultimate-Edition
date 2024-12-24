#macro MUSIC_NA -1

/// @function music_set
/// @param _music = MUSIC_NA
function music_set(_music = MUSIC_NA)
{
	var _music_previous = global.music;
		
	if (_music == _music_previous)
	{
		if (!audio_is_playing(_music) && _music != MUSIC_NA)
			music_play();
		exit;
	}
			
	music_stop();
	global.music = max(_music, MUSIC_NA);
	
	switch (global.music)
	{
		case MUSIC_NA:
			break;
		default:
			music_play();
			break;
	}
}

/// @function music_play
function music_play()
{
	global.music_id = audio_play_sound_on(global.audio_emitter_music, global.music, true, 0);
	global.music_is_playing = true;
}

/// @function music_stop
function music_stop()
{
	audio_stop_sound(global.music);
	global.music_is_playing = false;
}

/// @function music_pause
function music_pause()
{
	audio_pause_sound(global.music);
	global.music_is_playing = false;
}

/// @function music_resume
function music_resume()
{
	if (audio_is_paused(global.music))
	//{
		audio_resume_sound(global.music);
		global.music_is_playing = true;
	//}
}

/// @function volume_music_set
/// @param _volume
function volume_music_set(_volume)
{
	global.audio_settings.volume_music = _volume;
	global.audio_bus_music.gain = (volume_music_get() * volume_master_get());
}

/// @function volume_music_get
function volume_music_get()
{
	return global.audio_settings.volume_music;
}
