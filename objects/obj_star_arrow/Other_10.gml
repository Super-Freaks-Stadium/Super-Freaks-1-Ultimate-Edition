/// @description Step

var _curve_channel = animcurve_get_channel(animcurve_star_arrow, 0);

rotate_effect = rotate_effect_previous + rotate_speed;
rotate_speed = max(rotate_speed - 0.25, 1);
scale_effect = ((scale_effect_timer == 0) ? 1.0 : animcurve_channel_evaluate(_curve_channel, 1.0 - scale_effect_timer));
scale_effect_timer = max(scale_effect_timer - 0.035, 0);
hitbox.radius = min(hitbox.radius + 2, 32);
