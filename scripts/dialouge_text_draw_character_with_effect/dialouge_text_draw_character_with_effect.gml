// @desc
//
//
//
function dialouge_text_draw_character_with_effect(char, textX, textY, _effect, charDrawingPosition) {

	//Char 
	var cc = char;
	var fadeAlpha = clamp((cutoffContinuous-charDrawingPosition)/3, 0, 1);
	
	//Loop
	switch (_effect) {
		
		//--------------------------------------------------------------------
		//0
		default:
		case text_effect.fade:
		
			var c = Game.textDefCol;
			draw_text_colour(textX, textY, cc, c, c, c, c, fadeAlpha);
			
		break;
		//--------------------------------------------------------------------
		
		case text_effect.order:
		
			var c = Game.textOrderCol;
			draw_text_colour(textX, textY, cc, c, c, c, c, fadeAlpha);
			
		break;
		//--------------------------------------------------------------------
		
		case text_effect.balanced:
		
			var c = Game.textBalancedCol;
			draw_text_colour(textX, textY, cc, c, c, c, c, fadeAlpha);
			
		break;
		//--------------------------------------------------------------------
		
		case text_effect.chaos:
		
			var c = Game.textChaosCol;
			draw_text_colour(textX, textY, cc, c, c, c, c, fadeAlpha);
			
		break;
		//--------------------------------------------------------------------
		
		case text_effect.name:
		
			if (characterTalking != -1) {
				var c = charachter_get_name_colour(characterTalking.characterId);
				draw_text_colour(textX, textY, cc, c, c, c, c, fadeAlpha);
			}

		break;
		//--------------------------------------------------------------------
		
		case text_effect.typewritter:
		
			var c = Game.textDefCol;
			draw_text_colour(textX, textY, cc, c, c, c, c, 1);
			
		break;
		//--------------------------------------------------------------------
		
		case text_effect.wavy:
		
			var c = Game.textDefCol;
			var yy = sin((cutoffContinuous-(3*charDrawingPosition))/7);
			draw_text_colour(textX, textY + yy, cc, c, c, c, c, fadeAlpha);
			
		break;
		//--------------------------------------------------------------------
		
		case text_effect.rainbow:
		
			var h = ((effectTimer-charDrawingPosition)*8) % 255
			var c = make_colour_hsv(h, 100, 255);
			var yy = sin((effectTimer-(3*charDrawingPosition))/7);
			draw_text_colour(textX, textY + yy, cc, c, c, c, c, fadeAlpha);
			
		break;
			//--------------------------------------------------------------------
		
		case text_effect.glyph:
		
			var c = Game.textDefCol
			var chars = ".';:|[]()I`~";
			var rand = irandom(string_length(chars)+1);
			draw_text_colour(textX, textY, rand, c, c, c, c, fadeAlpha);
			
		break;
		//--------------------------------------------------------------------
		
		case text_effect.shake:
		
			var c = Game.textDefCol;
			var r = 0.5;
			var xx = random_range(-r, r);
			var yy = random_range(-r, r);
			draw_text_colour(textX+xx, textY+yy, cc, c, c, c, c, 1);
			
		break;
		//--------------------------------------------------------------------
	}

}