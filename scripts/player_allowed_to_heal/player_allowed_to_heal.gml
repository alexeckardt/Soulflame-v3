//
//DESC:
//
//
//
function player_allowed_to_heal() {
	return Player.hp < Player.currentMaxHealth && essence_token_has_amount(Player.healTokenCost)
}