/// @description 

var w = Camera.view_width;
var h = Camera.view_height;
var z = Camera.zoom;

//Draw Background
display_set_gui_size(w, h);

//Draw Black Rectangles at Varying Alphas to "Fadeout" Text
var fadeTotalHeight = bottomFadeHeight * h;
var fadeSectionHeight = fadeTotalHeight div bottomFadeSections;
var c = bottomFadeColour;
for (var i = 0; i < bottomFadeSections; i++) {

	var p = (bottomFadeSections-i) / bottomFadeSections * dialougeBottomFadePercent;
	draw_sprite_ext(sPixel, 0, 0, h-fadeSectionHeight*(i+1), w, fadeSectionHeight, 0, c, p);

}

//Draw Characters


//Draw 
draw_text(w div 2, h div 2, textToDisplay);