/// @description Init

state_machine_init();

hashmap_hitbox_cells = [];
hashmap_collider_cells = [];

comp_list_hitbox_init();

comp_list_collider_init();
collider_attach_init();
collider_detectors_init();
collider_detector_up_set();
collider_detector_down_set();
collider_detector_sides_set();
collision_flags = 0;

instance_attach = undefined;
instance_attach_list = [];

speed_h = 0;
speed_v = 0;
speed_x = 0;
speed_y = 0;
speed_path = 0;
x_previous = x;
y_previous = y;
direction_previous = direction;
x_start_frame = x;
y_start_frame = y;
start_room = room;
owner = undefined;

face_spawn = sign(image_xscale);
face = face_spawn;

image_speed = 0;
animate_speed = 0; //Updates animation once a frame

run_frame = false;

self_emitter = audio_emitter_create();
audio_emitter_bus(self_emitter, global.audio_bus_sfx);
audio_emitter_falloff(self_emitter, 512, 4096, 1);
self_emitter_offset = new vector2();


//show_debug_message("CREATE " + string(id) + " " + string(object_get_name(object_index)));