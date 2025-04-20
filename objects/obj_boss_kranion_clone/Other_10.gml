/// @description Step

var _angle, _collision_left, _collision_up, _collision_right, _collision_down, _my_x, _my_y;
var _speed, _target;

// Inherit the parent event
event_inherited();

collision_flags = 0;

switch (state)
{
	case BOSS_KRANION_CLONE_STATES.INTRO:
		if (state_begin)
		{
			teleport_timer = 1;
			animate_speed = 0.25;
            hitbox.active = hitbox_active.inactive;
		}
		
		teleport_timer = max(teleport_timer - 0.02, 0);
		
		if (teleport_timer == 0)
			state_next_set(BOSS_KRANION_CLONE_STATES.IDLE);
		break;
	case BOSS_KRANION_CLONE_STATES.IDLE:
		if (state_begin)
		{
			sprite_index = spr_boss_kranion_stand;
            image_index = 0;
            hitbox.active = hitbox_active.passive;
		}
		break;
	case BOSS_KRANION_CLONE_STATES.DEATH:
        if (state_begin)
        {
            depth = 201;
            speed_h = 0;
            speed_v = -8;
            sprite_index = spr_boss_kranion_death;
            image_index = 0;
            timer = 32;
            hitbox.active = hitbox_active.inactive;
        }
        speed_v += 0.25;
        image_xscale -= 0.025;
        image_yscale -= 0.025;
        x += speed_h;
        y += speed_v;
    
        timer--;
        if (timer <= 0)
        {
            instance_create_depth(x, y, 240, obj_boss_explosion);
            screen_shake(0, 8);
            instance_destroy();
            obj_boss_kranionminus.hp--;
        }
		break;
	default:
		break;
}