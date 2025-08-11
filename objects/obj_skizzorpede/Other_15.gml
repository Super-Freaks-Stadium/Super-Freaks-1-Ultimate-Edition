/// @description Death

var _frame_delta = global.delta;
var _segment;
var _speed_x = lengthdir_x(player_hit_speed_x, random(360)), _speed_y = lengthdir_y(player_hit_speed_x, random(360));
var _my_x = x, _my_y = y;

for (_segment = 1; _segment <= segments; ++_segment)
{
    _speed_x = lengthdir_x(player_hit_speed_x, random(360)); 
    _speed_y = lengthdir_y(player_hit_speed_x, random(360));
    
    with (hitbox[_segment])
        enemy_killed_create(_my_x + body.x_offset, _my_y + body.y_offset, spr_skizzorpede_body, 0, 0, 1, 1, angle, _speed_x, _speed_y);
}

_speed_x = lengthdir_x(player_hit_speed_x, random(360)); 
_speed_y = lengthdir_y(player_hit_speed_x, random(360));

with (hitbox[0])
    enemy_killed_create(_my_x + body.x_offset, _my_y + body.y_offset, spr_skizzorpede_head, 1, 0, 1, 1, angle, _speed_x, _speed_y);

yorbs_add(yorb_amount);
yorb_collect_effect_multi(,, yorb_amount);
sfx_play_global(sfx_zip);
instance_destroy();