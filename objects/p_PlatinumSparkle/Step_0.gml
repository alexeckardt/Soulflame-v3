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
		
		//Update Emitter
		var emitter = Game.particleViewer.noblendEmitter;
		var k = oKeira.id;
		part_emitter_region(sys, emitter, k.x-5, k.x+5, k.y-12, k.y+5, 
								ps_shape_rectangle, ps_distr_linear);

		//Emit Particles
		part_emitter_burst(sys, emitter, part_type, burstAmount);
		
	}
}