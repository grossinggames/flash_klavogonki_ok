package common.text
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	import flash.filters.BitmapFilterQuality; 
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author ... Gospodin.Sorokin
	 */
	public class Textor extends MovieClip
	{
		//[Embed(source="../../../lib/font/Turum2-Bold.ttf", fontFamily = "Turum", embedAsCFF = "false")]
		//public  var ConsolaFont:Class;
		private var status:TextField;
		private var sizz:int;
		private var color:uint;
		private var lightColor:uint;
		private var light:Boolean;
		private var align:Boolean;
		
		function Textor(text:String, sizz:int, color:uint, light:Boolean, lightColor:uint, align:Boolean )
		{
			this.sizz = Math.round(sizz);
			this.color = color;
			this.lightColor = lightColor;
			this.light = light;
			this.align = align;
			
			status = new TextField();
			addChild(status);
			
			replaceText(text);
		}
		public function replaceText (text:String) :void
		{
			removeChild(status);
			
			var newFormat:TextFormat = new TextFormat();
			newFormat.font = "Turum";
			newFormat.size = sizz;
			newFormat.color = color;
			
			status = new TextField();
			status.text = text;
			status.x = 0;
			status.y = 0;
			status.embedFonts = true;
			if (align) {
				status.autoSize = TextFieldAutoSize.CENTER;
			} else {
				newFormat.align = TextFormatAlign.LEFT;
			}
			status.defaultTextFormat = newFormat;
			status.setTextFormat (newFormat);
			status.multiline = true;
			status.wordWrap = true;
			status.width = 500;
			status.selectable = false;
			addChild(status);
			
			if (light) {
				var glow:GlowFilter = new GlowFilter(); 
				glow.color = lightColor; 
				glow.alpha = 1; 
				glow.blurX = 4; 
				glow.blurY = 4; 
				glow.quality = BitmapFilterQuality.MEDIUM; 
				status.filters = [glow];
			}
		}
	}
}