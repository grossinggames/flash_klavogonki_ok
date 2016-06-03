package common.text
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.filters.BitmapFilterQuality; 
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author ... Gospodin.Sorokin
	 */
	public class TextGame extends MovieClip
	{	
		//[Embed(source = "../../../lib/font/Turum2-Bold.ttf", fontFamily = "GameText", embedAsCFF = "false")]
		//[Embed(source="../../../lib/font/minttypelytigaprocondensed.ttf", fontFamily = "GameText", embedAsCFF = "false")]
		private var _gameFont:Class;
		private var _text:TextField;
		private var _endF:GlowFilter;
		private var _glowF:GlowFilter;
		private var _emptyF:GlowFilter;
		private var _formatOne:TextFormat;
		private var _formatTwo:TextFormat;
		private var _formatTree:TextFormat;
		
		public function TextGame(dir:String)
		{
			_formatOne = new TextFormat();
			_formatOne.font = "Turum";
			_formatOne.size = 24;
			_formatOne.color = 0x000000;
			_formatOne.align = TextFormatAlign.LEFT;
			//_formatOne.bold = false;
			
			_formatTwo = new TextFormat();
			_formatTwo.font = "Turum";
			_formatTwo.size = 24;
			_formatTwo.color = 0x000000;
			_formatTwo.align = TextFormatAlign.LEFT;
			//_formatTwo.bold = false;
			
			_formatTree = new TextFormat();
			_formatTree.font = "Turum";
			_formatTree.size = 24;
			_formatTree.color = 0xFFFFFF;
			_formatTree.align = TextFormatAlign.LEFT;
			
			_emptyF = new GlowFilter();
			_emptyF.color = 0x000000; 
			_emptyF.alpha = 0;
			_emptyF.blurX = 4; 
			_emptyF.blurY = 4; 
			_emptyF.quality = BitmapFilterQuality.MEDIUM; 
			
			_glowF = new GlowFilter(); 
			_glowF.color = 0x00FFFF; 
			_glowF.alpha = 1;
			_glowF.blurX = 4; 
			_glowF.blurY = 4; 
			_glowF.quality = BitmapFilterQuality.MEDIUM; 
			
			_endF = new GlowFilter();
			_endF.color = 0x00FFFF; 
			_endF.alpha = 1;
			_endF.blurX = 4; 
			_endF.blurY = 4; 
			_endF.quality = BitmapFilterQuality.MEDIUM; 
			
			_text = new TextField();
			_text.text = dir;
			_text.x = 0;
			_text.y = 0;
			_text.embedFonts = true;
			//_text.defaultTextFormat = _formatOne;
			_text.setTextFormat (_formatOne);
			_text.multiline = false;
			_text.wordWrap = true;
			//_text.autoSize= TextFieldAutoSize.LEFT;
			_text.filters = [_emptyF];
			_text.width = 400;
			_text.selectable = false;
			addChild(_text);
		}
		public function selectText(dir:Boolean) : void
		{
			if (dir) {
				_text.setTextFormat(_formatTwo);
				_text.filters = [_glowF];
			} else {
				_text.setTextFormat(_formatTree);
				_text.filters = [_endF];
			}
		}
		private function init():void
		{
			//trace('Class Button init');
		}
	}
}