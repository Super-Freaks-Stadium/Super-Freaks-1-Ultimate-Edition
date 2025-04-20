/// @description Step

var _attack_x, 
    _attack_y;

switch (state)
{
    case boss_kranionminus_states.intro:
        if (state_begin)
        {
            y = room_height;
            sfx_play_global(sfx_rumble, true);
        }
        screen_shake(0, 8);
        y = max(y - 4, 592);
        if (y == 592)
        {
            screen_shake(0, 0);
            audio_stop_sound(sfx_rumble);
            state_next_set(boss_kranionminus_states.normal);
        }
        break;
    case boss_kranionminus_states.normal:
        if (state_begin)
        {
            timer = 0;
        }
        timer--;
        if (timer <= 0)
        {
            timer = 160; 
            _attack_x = locations_summon[location_current][0]; 
            _attack_y = locations_summon[location_current][1];
            instance_create_layer(_attack_x, _attack_y, "layer_instances", obj_boss_kranion_clone);
            location_current = (location_current + 1) mod array_length(locations_summon);
        }
        break;
}
