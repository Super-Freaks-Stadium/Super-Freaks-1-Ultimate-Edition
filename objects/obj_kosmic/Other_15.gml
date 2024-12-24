/// @description Death

yorbs_add(yorb_amount);
yorb_collect_effect_multi(,, yorb_amount);
enemy_killed_create(,,,1, 1, face * 90, player_hit_speed_x,,);
sfx_play_local(sfx_zip);
instance_destroy();