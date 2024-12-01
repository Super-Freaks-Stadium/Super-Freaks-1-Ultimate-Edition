function virtual_buttons_init()
{
    global.virtual_button_thumbstick = input_virtual_create().thumbstick("", "left", "right", "up", "down");
    global.virtual_button_jump = input_virtual_create().button("jump");
    global.virtual_button_bubble = input_virtual_create().button("bubble");
    global.virtual_button_confirm = input_virtual_create().button("confirm");
    global.virtual_button_deny = input_virtual_create().button("deny");
    global.virtual_button_start = input_virtual_create().button("start");
}

function virtual_buttons_step()
{
    var _screen_width = screen_width_get();
    var _screen_height = screen_height_get();
    var _screen_upscale = global.visuals_settings.upscale_internal;
    
    var thumbstick_position_x = (0 + 96) * _screen_upscale;
    var thumbstick_position_y = (_screen_height - 96) * _screen_upscale;
    var thumbstick_radius = 96 * _screen_upscale;
    var thumbstick_min_threshold = 24 * _screen_upscale;
    var thumbstick_max_threshold = 64 * _screen_upscale;
    var primary_position_x = (_screen_width - 96) * _screen_upscale;
    var primary_position_y = (_screen_height - 96) * _screen_upscale;
    var primary_radius = 64 * _screen_upscale;
    var secondary_position_x = (_screen_width - 192) * _screen_upscale;
    var secondary_position_y = (_screen_height - 64) * _screen_upscale;
    var secondary_radius = 32 * _screen_upscale;
    var start_shape = [
        (_screen_width - 40) * _screen_upscale, 
        (0 + 8) * _screen_upscale, 
        (_screen_width - 8) * _screen_upscale, 
        (0 + 40) * _screen_upscale
    ];
    var confirm_shape = [
        (_screen_width - 40 - 48) * _screen_upscale, 
        (0 + 8) * _screen_upscale, 
        (_screen_width - 8 - 48) * _screen_upscale, 
        (0 + 40) * _screen_upscale
    ];
    var deny_shape = [
        (_screen_width - 40 - 96) * _screen_upscale, 
        (0 + 8) * _screen_upscale, 
        (_screen_width - 8 - 96) * _screen_upscale, 
        (0 + 40) * _screen_upscale
    ];
    
    global.virtual_button_thumbstick.circle(thumbstick_position_x, thumbstick_position_y, thumbstick_radius).threshold(thumbstick_min_threshold, thumbstick_max_threshold);
    global.virtual_button_jump.circle(primary_position_x, primary_position_y, primary_radius);
    global.virtual_button_bubble.circle(secondary_position_x, secondary_position_y, secondary_radius);
    global.virtual_button_start.rectangle(start_shape[0], start_shape[1], start_shape[2], start_shape[3]);
    global.virtual_button_confirm.rectangle(confirm_shape[0], confirm_shape[1], confirm_shape[2], confirm_shape[3]);
    global.virtual_button_deny.rectangle(deny_shape[0], deny_shape[1], deny_shape[2], deny_shape[3]);
}

function virtual_buttons_draw_gui()
{
    surface_set_target(application_surface);
    gpu_set_depth(-9999);
    draw_set_alpha(1);
    draw_set_color(c_white);
    input_virtual_debug_draw();
    surface_reset_target();
}