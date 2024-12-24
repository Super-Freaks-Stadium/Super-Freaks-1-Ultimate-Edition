/// @function sfx_play_global
/// @param _sound
/// @param {boolean} _loop = false
/// @param {int} _priority = 0
function sfx_play_global(_sound, _loop = false, _priority = 0)
{
	return audio_play_sound_on(global.audio_emitter_sfx, _sound, _loop, _priority);
}

/// @function sfx_play_local
/// @param _sound
/// @param {boolean} _loop = false
/// @param {int} _priority = 0
function sfx_play_local(_sound, _loop = false, _priority = 0)
{
    return audio_play_sound_on(self_emitter, _sound, _loop, _priority);
}

/// @function volume_sfx_set
/// @param _volume
function volume_sfx_set(_volume)
{
	global.audio_settings.volume_sfx = _volume;
    global.audio_bus_sfx.gain = (volume_sfx_get() * volume_master_get());
}

/// @function volume_sfx_get
function volume_sfx_get()
{
	return global.audio_settings.volume_sfx;
}
