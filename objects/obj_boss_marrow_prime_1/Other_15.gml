/// @description Death

instance_create_layer(x, y, "layer_instances", obj_boss_marrow_prime_2);
global.boss_phase = 2;
turbo_time_add(30);
instance_destroy();