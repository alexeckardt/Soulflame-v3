// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function title_screen_popup_create(title, body) {
	var popup = instance_create_depth(x, y, 0, oTitleScreenPopup);
	popup.titleString = title;
	popup.bodyString = body;
	
	return popup;
}