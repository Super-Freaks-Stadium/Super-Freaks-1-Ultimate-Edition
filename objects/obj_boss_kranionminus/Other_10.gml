/// @description Step

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
}
