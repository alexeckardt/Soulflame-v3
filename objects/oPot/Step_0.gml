/// @description 
var damageMeeting = instance_place(x, y, oDamage);

if (damageMeeting != noone) {
	
	//Chjeck If Player Damage
	if (damageMeeting.creator.object_index = oKeira) {
		
		//Create Particles
		particle_create_pot_frag(bbox_left, bbox_top, bbox_right, bbox_bottom+5, 8, potPartTypeSpr, partTypeKey);
		particle_create_dust(bbox_left, bbox_bottom-5, bbox_right, bbox_bottom+5, 5);
		
		//Destroy
		instance_destroy();
		
	}
	
}