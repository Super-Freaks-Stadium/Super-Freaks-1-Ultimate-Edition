/// @description Step

rotate_effect_previous = rotate_effect mod 360;
rotate_effect = rotate_effect_previous + rotate_speed;
rotate_speed = max(rotate_speed - 0.25, 1);
var _curve_channel = animcurve_get_channel(animcurve_star_arrow, 0);
scale_effect_previous = scale_effect;
scale_effect = ((scale_effect_timer == 0) ? 1.0 : animcurve_channel_evaluate(_curve_channel, scale_effect_timer));
scale_effect_timer = max(scale_effect_timer - 0.04, 0);
hitbox.radius = min(hitbox.radius + 2, 32);
