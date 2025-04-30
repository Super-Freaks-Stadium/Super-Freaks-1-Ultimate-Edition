/// @description Death

/*
enemy_killed_create(spr_boss_marrow_prime_sit_death,,,,,, player_hit_speed_x, -6);
yorbs_add(yorb_amount);
yorb_collect_effect_multi(,, yorb_amount);
sfx_play_global(sfx_zip);
*/
instance_create_layer(x, y, "layer_instances", obj_boss_marrow_prime_2);
global.boss_phase = 2;
turbo_time_add(30);
instance_destroy();