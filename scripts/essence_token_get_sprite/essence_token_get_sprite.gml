//
//DESC:
//
//
//
function essence_token_get_sprite(_alignment) {

	switch (_alignment) {
		case essence.balance: return sEssenceTokenBalance;
		case essence.chaos: return sEssenceTokenChaos;
		case essence.order: return sEssenceTokenOrder;
	}

	return sEssenceTokenSlot;
	
}