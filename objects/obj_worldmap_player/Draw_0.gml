/// @description 

var _frame_delta = frame_delta_game_get();
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);

if (is_undefined(global.player_lead))
    return;

var _player_character = global.player_list[global.player_lead][player_data.character_index];

draw_sprite(spr_player_numbers_arrows, global.player_lead, _x, _y - 24);
draw_sprite(player_animation_get(_player_character, player_animations.hud_face), 0, _x, _y);