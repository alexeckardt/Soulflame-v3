//
//DESC:
//
//
//
function flower_create_effect_struct(flowerType, mutator) {


	//Create struct
	var struct = new FlowerEffect(flowerType);
	struct.mutatorAdded = mutator;

	//Stats
	var baseMulti = 1;
	var baseTime = 1;

	//For Readability
	var addedHeart = mutator == 1;
	var addedBone = mutator == 2;

	//Mutators Based on Flower type
	switch (flowerType) {
		
		case flower.lapis_radiance: 
			baseMulti	= 1 + addedHeart;
			baseTime	= 1 + addedBone;
			break;
		case flower.scarlet_fawn:
			break;
		case flower.fuchsia_lily:
			break;
		case flower.amber_trillium:
			break;
		case flower.sun_violet:
			break;
		case flower.diamond_daisy:
			break;
		case flower.aquamarine_star:
			break;
		case flower.summer_floral:
			break;
		case flower.rose_sunflower:
			break;
		case flower.violet_lily	:
			break;
		
	}
	
	//Save
	struct.effectiveness = baseMulti;
	struct.campfiresLeft = baseTime;
	
	//Return
	return struct;

}