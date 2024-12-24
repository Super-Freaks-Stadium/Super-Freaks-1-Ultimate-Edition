/// @description Init

// Inherit the parent event
event_inherited();

hitbox = new comp_hitbox_circle(,,,,, 96);
sfx_play_local(sfx_falling_piano_1);
can_despawn = false;
animate_speed = 0.25;
rectangle_fade = 0;