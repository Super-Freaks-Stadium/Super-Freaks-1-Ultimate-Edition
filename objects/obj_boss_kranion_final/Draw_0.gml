/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _aura_angle = lerp_360(aura_angle_previous, aura_angle, _frame_delta);
var _spike_angle = lerp_360(spike_angle_previous, spike_angle, _frame_delta);
var _face_angle = lerp_360(face_angle_previous, face_angle, _frame_delta);

var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _view_width = view_width_get();
var _view_height = view_height_get();

if (state == boss_kranion_final_states.intro_1)
{
	surface_set_target(global.surface_HUD);
	draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);
}

if (state == boss_kranion_final_states.death_2)
{
	draw_sprite(sprite_death, 0, _x, _y);
}
else
{
	draw_sprite_ext(sprite_aura, 0, _x, _y, aura_size, aura_size, _aura_angle, c_white, 1);
	draw_sprite_ext(sprite_spikes, 0, _x, _y, spike_size, spike_size, _spike_angle, c_white, 1);
	draw_sprite(spr_boss_kranion_ultimate_body, 0, _x, _y);
	draw_sprite_ext(sprite_face, image_index, _x, _y, 1, 1, _face_angle, c_white, 1);
}

if (state == boss_kranion_final_states.intro_1)
{
	surface_reset_target();
	draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);
}