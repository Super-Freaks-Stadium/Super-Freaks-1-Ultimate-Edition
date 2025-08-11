/// @description Death

enemy_killed_create(,,, 1,,,,, player_hit_speed_x * 2,);
enemy_killed_create(,,, 0,,,, angle, player_hit_speed_x,);
yorbs_add(yorb_amount);
yorb_collect_effect_multi(,, yorb_amount);
sfx_play_global(sfx_zip);
instance_destroy();