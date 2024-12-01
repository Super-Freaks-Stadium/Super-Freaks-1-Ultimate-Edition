enum audio_data //LEGACY
{
	volume_music = 0,
	volume_sfx,
    volume_master,
}

/// @function audio_init
function audio_init()
{
	global.audio_settings = 
    {
        volume_master: 1.0,
        volume_music: 0.75,
        volume_sfx: 0.8
    }
	global.audio_emitter_music = audio_emitter_create();
	global.audio_emitter_sfx = audio_emitter_create();
        
	audio_load();
        
	audio_emitter_gain(global.audio_emitter_music, volume_music_get() * volume_master_get());
    audio_emitter_gain(global.audio_emitter_sfx, volume_sfx_get() * volume_master_get());
		
	global.music = MUSIC_NA;
}

/// @function audio_save
function audio_save()
{
    var _snap = SnapToJSON(global.audio_settings, true,, true)
	string_save(_snap, "settings/audio.json");
}

/// @function audio_load
function audio_load()
{
    //TODO Legacy Save Check
    
	if file_exists("settings/audio.json")
	{
		var _json = string_load("settings/audio.json");
        var _snap = SnapFromJSON(_json);
		
		global.audio_settings = _snap;
	}
}

/// @function volume_master_set
/// @param _volume
function volume_master_set(_volume)
    {
    global.audio_settings.volume_master = _volume;
}

/// @function volume_music_get
function volume_master_get()
    {
    return global.audio_settings.volume_master;
}
