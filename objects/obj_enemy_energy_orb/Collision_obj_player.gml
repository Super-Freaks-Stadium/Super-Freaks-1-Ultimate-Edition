/// @description 

if (hit == false)
{
	if (other.ball == true)
	{
		hit = true;
		sfx_play_local(sfx_bonk_coconut_1);
		speed *= 2;
		direction = (direction + 180) mod 360;
	}
	else
	{
		with (other)
			player_hurt();
		instance_destroy();
	}
}