/// @description Death

enemy_killed_create(,,,,,, player_hit_speed_x,,);
yorbs_add(yorb_amount);
yorb_collect_effect_multi(,, yorb_amount);
sfx_play_local(sfx_zip);
instance_destroy();