/// @description 

instance_destroy();
yorbs_add();
sfx_play_local(sfx_yorb);
instance_create_layer(x, y, "layer_instances", obj_yorb_collected_single);
	