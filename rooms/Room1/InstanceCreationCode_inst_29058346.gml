
interactable = true;
repeatable = true;
interactMessage = lang_get_text("ui.interact.listen");
activate = false;

//shopoptions = ["dialogue.answer.shop", "dialogue.answer.talk", "dialogue.answer.leave"];

t_scene_info = [

	[cutscene_event_wait_time, 0.2],
	[cutscene_dialouge_base, "test", [character.keira, character.base2, character.base, ], 1, false, 1],
	
	[cutscene_dialouge_base, "test2", [character.keira, character.base, character.base2], 2, false],
	
	[cutscene_dialouge_base, "test3", [character.base2], 0, false],
	
	[cutscene_event_wait_time, 3],
	
	[cutscene_dialouge_base, "test4", [character.base2], 0, false],
	
	[cutscene_dialouge_question, "empty", ["test4.option1", "test4.option2"], [character.base2], 0, false],
	
	//
	//Selected: Take The Bait
	//
	
	/**/ [cutscene_path_run_event, 0, 
			[cutscene_dialouge_base, "test", [character.keira, character.base2, character.base, ], 1, false],
			],
	/**/ [cutscene_path_run_event, 0, 
			[cutscene_dialouge_base, "test3", [character.keira, character.base2, character.base, ], 1, false],
			],
		
	//
	//Selected: Ignore
	//
		
		/**/ [cutscene_path_run_event, 1, 
			[cutscene_dialouge_base, "test2", [character.keira, character.base2, character.base, ], 1, false],
			],
	
	
	
	//[cutscene_dialouge_question, "dialouge.shopkeeper.main", shopoptions, [character.keira, character.base], 1, true],

]
