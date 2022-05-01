/// @description Timed Emittion

sparklesToCreate = clamp(sparklesToCreate, 0, 300)
if (sparklesToCreate > 0) {

	//Timer
	timer -= Game.delta;
	
	//Create Sparkle
	if (timer < 0) {
		
		//Setup
		var burstAmount = irandom_range(1, clamp(sparklesToCreate/10, 1, 30));
		var sys = Game.particleViewer.noblendSys;
		
		//Reset
		sparklesToCreate -= burstAmount;	
		timer = irandom(room_speed div 6); //< 1/6 second
		
		//Get objs
		var emitter = Game.particleViewer.noblendEmitter;
		var k = oKeira.id;
		
		//pos
		var x1 = k.x-8;
		var x2 = k.x+8;
		var y1 = k.y-18;
		var y2 = k.y+5;
		
		//Update Emitter
		part_emitter_region(sys, emitter, x1, x2, y1, y2, 
								ps_shape_rectangle, ps_distr_linear);

		//Emit Particles
		part_emitter_burst(sys, emitter, part_type, burstAmount);
		
		//Light Particles
		create_platinum_light_particles(choose(0, 0, 1, 2),x1,x2,y1,y2);
		
	}
}