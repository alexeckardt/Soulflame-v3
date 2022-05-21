//
//DESC:
//
//
//
function FlowerEffect(_flower) constructor {
	
	effect = _flower;
	
	campfiresLeft = 1;
	campfiresLeftOrg = campfiresLeft;
	effectiveness = 1;
	
	//For Display
	mutatorAdded = 0;

	static draw = function(xx, yy) {
	
		var percentUsed= campfiresLeft / campfiresLeftOrg;
		
		if (mutatorAdded != 0) {
			draw_sprite(sInventoryFlowerMutators, mutatorAdded, xx + 2, yy + 2);
		}
	
		//Base
		var spr = sinventoryFlowerIcon;
		draw_sprite(spr, effect, xx, yy);
		
		var xof = sprite_get_xoffset(spr);
		var yof = sprite_get_yoffset(spr);
		
		//Darken Based on P
		var w = sprite_get_width(spr);
		var h = sprite_get_height(spr);
		draw_sprite_part_ext(spr, effect, 0, 0, w, h*(1-percentUsed), xx-xof, yy-yof, 1, 1, c_dkgray, 1);
	
		
	}

}