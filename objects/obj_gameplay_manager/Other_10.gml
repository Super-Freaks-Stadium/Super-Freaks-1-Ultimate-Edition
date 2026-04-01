/// @description Step

yorb_effect = max(yorb_effect - 0.25, 0);

heart_radius = (heart_radius + 8) mod 360;
heart_shake = max(heart_shake - 0.5, 0);

metalpipe_delay--;
if (metalpipe_delay < 1)
{
    metalpipe_delay = random_range(96, 6767);
    if (global.modifiers[modifiers.metalpipe])
        sfx_play_global(sfx_metalpipe, false, 10);
}