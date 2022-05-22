//
//DESC:
//
//
//
function player_allowed_to_heal() {
	return Player.hp < Player.heartCount && essence_token_has_amount(Player.healTokenCost) && Player.allowHealing
}