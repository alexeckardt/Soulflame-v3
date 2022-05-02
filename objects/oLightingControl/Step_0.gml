/// @description  Update and Destroy

if (instance_exists(Camera)) {

	Camera.shadowColour = shadow_colour;
	Camera.maxDarknessOpacity = shadow_strength;
	Camera.maxDarknessOpacityTo = shadow_strength;

	instance_destroy();

}