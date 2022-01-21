/// @description 

event_inherited();

var time = Game.delta;

if (hasHitGroundOnce) {
	spinNow = true;}
	
	
if (spinNow) {	angSpeed = abs(vSpeed)*hSpeed*10; spinNow = false; }
angle += angSpeed*time;
angSpeed = lerp(angSpeed, 0, 0.01*time);

if (onGround) {
	angSpeed /= 2*time;	}