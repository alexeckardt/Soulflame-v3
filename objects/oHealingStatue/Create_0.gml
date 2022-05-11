/// @description 

event_inherited();

image_speed = 0;

glow = false;
glowbyProx = false;
glowAlpha = 0;
glowAlphaTo = 0;

glowProxActiveRange = 100;
glowProxMaxGlowRange = 30;

regIndex = 0;
darkIndex = 1;
glowOverlayIndex = 2;

persistenceId = "healing_statue_activated";


//Trigger
repeatable = false;
interactMessage = lang_get_text("ui.interact.interact");
interactable = true;

first_activate_scene = [

	

];
