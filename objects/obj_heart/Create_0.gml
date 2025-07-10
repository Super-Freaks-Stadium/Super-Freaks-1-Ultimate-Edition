/// @description 

// Inherit the parent event
event_inherited();

image_index = (x + y) mod image_number;
despawn_area[0] = -16;
despawn_area[1] = -16;
despawn_area[2] = 16;
despawn_area[3] = 16;

if (global.turbo.mode)
    sprite_index = spr_time_clock;
else
{
    if (hearts_maximum_get() == 0)
    	instance_destroy();
}

image_xscale = mirror_flip_get();