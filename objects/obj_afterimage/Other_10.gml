/// @description Step

timer -= 0.5;

image_alpha -= 0.25;
if (image_alpha < 0) 
    instance_destroy();