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
			baseMulti	= 1 + addedHeart;
			baseTime	= 1 + addedBone;
			break;
		case flower.fuchsia_lily:
			baseMulti	= 1;
			baseTime	= 1 + addedBone;
			break;
		case flower.amber_trillium:
			baseMulti	= 1;
			baseTime	= 1 + addedBone*2;
			break;
		case flower.sun_violet:
			baseMulti	= 1 + addedHeart;
			baseTime	= 1 + addedBone;
			break;
		case flower.cloud_daisy:
			baseMulti	= 1 + addedHeart*2;
			baseTime	= 1 + addedBone;
			break;
		case flower.aquamarine_star:
			baseMulti	= 1;
			baseTime	= 1 + addedBone*2;
			break;
		case flower.summer_floral:
			baseMulti	= 1 + addedHeart;
			baseTime	= 1 + addedBone;
			break;
		case flower.rose_sunflower:
			baseMulti	= 1 + addedHeart;
			baseTime	= 1 + addedBone;
			break;
		case flower.violet_lily	:
			baseMulti	= 1 + addedHeart;
			baseTime	= 1 + addedBone;
			break;
		
	}
	
	//Save
	struct.effectiveness = baseMulti;
	struct.campfiresLeft = baseTime;
	struct.campfiresLeftOrg = baseTime;
	
	//Return
	return struct;

}