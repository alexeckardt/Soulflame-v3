/// @description Destroy

part_type_destroy(smokeTitleType);
part_type_destroy(emberTitleType);

part_emitter_destroy(smokeTitleSys, smokeTitleEmit);
part_system_destroy(smokeTitleSys);

instance_destroy();