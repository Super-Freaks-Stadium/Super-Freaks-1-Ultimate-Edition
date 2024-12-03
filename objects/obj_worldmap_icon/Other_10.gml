/// @description Step

pic_alpha_previous = pic_alpha;

if (hover_over == true)
{
	pic_alpha = min(pic_alpha + 0.1, 1);
	depth = -5;
}
else
{
	pic_alpha = max(pic_alpha - 0.1, 0);
	depth = 0;
}
	
hover_over = false;