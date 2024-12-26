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
        
    global.audio_bus_music = audio_bus_create();
    global.audio_bus_sfx = audio_bus_create();
        
	global.audio_emitter_music = audio_emitter_create();
	global.audio_emitter_sfx = audio_emitter_create();
        
	audio_load();
        
	global.audio_bus_music.gain = (volume_music_get() * volume_master_get());
    global.audio_bus_sfx.gain = (volume_sfx_get() * volume_master_get());
        
    audio_emitter_bus(global.audio_emitter_music, global.audio_bus_music);
    audio_emitter_bus(global.audio_emitter_sfx, global.audio_bus_sfx);
		
    audio_falloff_set_model(audio_falloff_inverse_distance);
    audio_listener_orientation(0, 0, 1, 0, -1, 0);
    audio_listener_position(0, 0, -512);
        
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

/// @function audio_step
function audio_step()
{
    var _view_center_x = view_x1_get() + (view_width_get() / 2);
    var _view_center_y = view_y1_get() + (view_height_get() / 2);
    audio_emitter_position(global.audio_emitter_music, _view_center_x, _view_center_y, -512);
    audio_emitter_position(global.audio_emitter_sfx, _view_center_x, _view_center_y, -512);
    with obj_master
    {
        if (self_emitter_auto_adjust)
            audio_emitter_position(self_emitter, x + self_emitter_offset.x, y + self_emitter_offset.y, 0);
    }
    audio_listener_position(_view_center_x, _view_center_y, -512);
}

/// @function volume_master_set
/// @param _volume
function volume_master_set(_volume) 
{
    global.audio_settings.volume_master = _volume;
    global.audio_bus_music.gain = (volume_music_get() * volume_master_get());
    global.audio_bus_sfx.gain = (volume_sfx_get() * volume_master_get());
}

/// @function volume_music_get
function volume_master_get() 
{
    return global.audio_settings.volume_master;
}
