	
//Lose Platinum
	
//Calculate Value. Complicated Formula. Basically:
//At Low Values, Lost Platinum is a sizeable drop percent, but the absolute amount lost is not much.
//At Realistic End Game Values (Maybe, Idk Yet), the drop is reasonable, but not a significant percentage of your bank).
	
//h = 6 
//10 plt = 2.6 lost		(~26%)
//100 plt = 13.1 lost	(~13%)
//1 000 plt = 87.3 lost (~9%)
//10 000 plt= 668 is lsot (~7%)
//100 000 plt= 5 276 is lsot (~5%)
	
//h controls the falloff. lower h means lower fall off means higher amount lost. Values Below 2 Can result in more platinum lost than you had.
//
	
function player_drop_platinum_death(k){

	var originalPlatinum = platinum;
	var h = 6//(!talisman_check_equipt(talisman.platinum_pouch))? 6 : 12;
	var lostAmount = max(logn(h, abs(originalPlatinum) + 1) + power(originalPlatinum, 0.9)/h, 0);
	
	//Drop
	platinum -= floor(lostAmount);
	
	//Drop Platinum Objects
	var platinumDropped = floor(lostAmount * 6.5 / 8);
	platinum_create(k.x, k.y, platinumDropped, 3, 1.4, 2);
	
}