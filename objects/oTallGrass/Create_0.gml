/// @description 

randomize();

disableBuffer = 16;

image_speed = 0;
image_xscale = 1;
image_index = irandom(image_number);

ampli = random_range(3, 7);
period = irandom_range(100, 300);
myAngle = irandom_range(-4, 4);
myOffsetTime = irandom_range(0, period);

justCollided = false;
timeShook = current_time;
shakeIntensity = 0;
shakeDir = 0;

shakeChance = 1.1;
checkedForDie = false;

imY = random_range(.8, 1.2);
yscaleTo = imY;
yscale = imY;
squiedHoldFor = 0;

if (place_meeting(x, y-10, Solid)) { instance_destroy(); }

onStart = 0;
wasColliding = false;
