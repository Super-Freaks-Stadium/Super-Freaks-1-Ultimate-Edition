/// @description Step

x_previous = x;
y_previous = y;

speed_v = min(speed_v + speed_grv, 6);

x += speed_h;
y += speed_v;