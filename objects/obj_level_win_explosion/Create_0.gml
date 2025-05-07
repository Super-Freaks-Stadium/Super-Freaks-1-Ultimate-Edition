/// @description Init

// Inherit the parent event
event_inherited();

animate_speed = 0.25;
image_xscale = 4;
image_yscale = 4;
music_stop();
game_timer_pause(true);
screen_shake(0, 16);
timer = 32;
global.turbo.pause = true;
