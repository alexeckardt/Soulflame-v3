// @desc
//
//
//
function menu_pages_create(){


	//Display Keys Should Be ONLY the suffix (eg, no 'menu.e.XXX', just 'XXX')
	//Descriptions will have identical keys, but with '.desc' appeneded onto it.
	
	// Run Simple Script on Press:		[displayLangKey", m_e.script_runner, scriptToRun]
	// Change Variable on Press:		[displayLangKey, m_e.shift_through_indexes, instance, variableName, [whatToDisplayForEachOption]]


	var p = Player.id;
	var g = Game.id;

	master_page = menu_page_create("menu.page.main",
			[
	
				//["",						m_e.script_runner,	],
				["hitboxes",		m_e.shift_through_indexes,	g, "viewHitboxes",		["option.hidden", "option.visible"]],
				["damageBoxes",		m_e.shift_through_indexes,	g, "viewDamageBoxes",	["option.hidden", "option.visible"]],
	
			]
			);
				
	

}