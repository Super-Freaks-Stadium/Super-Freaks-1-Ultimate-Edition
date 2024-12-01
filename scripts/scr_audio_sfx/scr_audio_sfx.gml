/// @function sfx_play_global
/// @param _sound
/// @param {boolean} _loop = false
/// @param {int} _priority = 0
function sfx_play_global(_sound, _loop = false, _priority = 0)
{
	return audio_play_sound_on(global.audio_emitter_sfx, _sound, _loop, _priority);
}

/// @function volume_sfx_set
/// @param _volume
function volume_sfx_set(_volume)
{
	global.audio_settings.volume_sfx = _volume;
    audio_emitter_gain(global.audio_emitter_sfx, _volume * volume_master_get());
}

/// @function volume_sfx_get
function volume_sfx_get()
{
	return global.audio_settings.volume_sfx;
}
