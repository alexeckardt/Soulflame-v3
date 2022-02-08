/// @desc - Create Command List

commands = ds_list_create();
ds_list_add(commands, ["{entity} {x} {y}",	command_summon]);
ds_list_add(commands, ["{pointInGame}",		command_ability]);
ds_list_add(commands, ["{action} [value]",	command_health]);
ds_list_add(commands, ["[saveFileName]",	command_load]);
ds_list_add(commands, ["{action} {value}",	command_essence]);
ds_list_add(commands, ["{amount}",			command_money]);
ds_list_add(commands, ["",					command_lab]);
ds_list_add(commands, ["{roomName}",		command_room]);
ds_list_add(commands, ["",					command_save]);
ds_list_add(commands, ["{x} {y} {rel}",		command_tp]);
ds_list_add(commands, ["{command}",			command_misc]);