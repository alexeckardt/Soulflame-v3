// @desc
//
//
//
function menu_pages_create(){


	//Display Keys Should Be ONLY the suffix (eg, no 'menu.e.XXX', just 'XXX')
	//Descriptions will have identical keys, but with '.desc' appeneded onto it.
	
	// Run Simple Script on Press:		[displayLangKey", m_e.script_runner, scriptToRun]
	// Change Variable on Press:		[displayLangKey, m_e.shift_through_indexes, instance, variableName, [whatToDisplayForEachOption]]
	// Change Slider:					[displayLangKey, m_e.slider, instance, variableName, minValue, maxValue, segments]
	// Change Page:						["Button Name",	m_e.shift_through_indexes, instance, variableName, [whatToDisplayForEachOption]]


	var p = Player.id;
	var g = Game.id;

	master_page = menu_page_create("menu.page.main",
			[
	
				["resume",		m_e.script_runner,	menu_close_menu, []],
				[],
				["options",		m_e.page_transfer,	"options_page", ],
				["feedback",	m_e.page_transfer,	"feedback_bugs_page", ],
				["statistics",	m_e.page_transfer,	"statistics_page", ],
				[],
				["title",		m_e.script_runner,	menu_return_to_title, []],
			],
			
			false
			);
	
	options_page = menu_page_create("menu.page.options",
			[
				["back",				m_e.page_transfer,	"master_page", ],
				[],
				["showui",				m_e.shift_through_indexes,	p, "showUI",			["option.hidden", "option.visible"]],
				["uiscale",				m_e.slider,					p, "uiScale",			0.25, 1.5, 5, true],
				["windowmode",			m_e.shift_through_indexes,	g, "fullscreen",		["option.windowed", "option.fullscreen"]],
				["frameSkips",			m_e.shift_through_indexes,	g, "frameSkips",		["option.skip0", "option.skip1", "option.skip2", "option.skip3", "option.skip4"]],
				[],
				["paralax",				m_e.slider,				g, "paralaxScale",	0, 1.5, 15, true],
				[],
				["audio",				m_e.page_transfer,	"audio_page", ],
				["debugsettings",		m_e.page_transfer,	"debug_settings_page", ],
			]
			);

	
	audio_page = menu_page_create("menu.page.audio",
			[
				["back",				m_e.page_transfer,	"master_page", ],
				[],
			]
			);
			
			
	debug_settings_page = menu_page_create("menu.page.debugsettings",
			[
	
				//["",						m_e.script_runner,	],
				["back",				m_e.page_transfer,			"options_page", ],
				[],
				["showdebug",		m_e.shift_through_indexes,	g, "showDebugOverlay",	["option.hidden", "option.visible"]],
				[],
				["hitboxes",		m_e.debug_conditional,	g, "viewHitboxes",		["option.hidden", "option.visible"]],
				["damageBoxes",		m_e.debug_conditional,	g, "viewDamageBoxes",	["option.hidden", "option.visible"]],
				["audioSource",		m_e.debug_conditional,	g, "viewAudioEmitters",	["option.hidden", "option.visible"]],
				
				
	
			]
			);
				
	statistics_page = menu_page_create("menu.page.statistics",
			[
	
				["back",				m_e.page_transfer,	"master_page", ],
				[],

			]
			);
			
	feedback_bugs_page = menu_page_create("menu.page.feedback",
			[
	
				["back",				m_e.page_transfer,	"master_page", ],
				[],
	
			]
			);

}