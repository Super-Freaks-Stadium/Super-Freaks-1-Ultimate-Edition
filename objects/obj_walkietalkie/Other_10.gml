/// @description Step

if (display)
    alpha = min(alpha + 0.15, 1);
else
	alpha = max(alpha - 0.15, 0);
display = false;
