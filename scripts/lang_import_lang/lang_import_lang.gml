// @desc
//
//
//
function lang_import_lang(language_id) {

	var l = Lang;
	
	ds_map_clear(l.lang);
	script_execute(l.langScripts[language_id]);

	lang_get_text("c.cutscene_name.example")

	return -1;

}