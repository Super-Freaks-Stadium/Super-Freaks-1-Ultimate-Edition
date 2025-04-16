if (other.hit)
{
	enemy_hurt();
	with (other)
		instance_destroy();
}