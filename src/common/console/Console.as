package common.console 
{
	import flash.text.*;
	import flash.display.*;
	import flash.ui.*;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Gospodin.Sorokin
	 */
	public class Console extends Sprite 
	{
		private var tf: TextField;
		private var box : Shape;
		private var alp : Boolean;
		//private static var stage : Stage;
		
		public function Console() 
		{
			box = new Shape();
			addChild(box);
			
			tf = new TextField();
			tf.x = 10;
			tf.y = 50;
			tf.width = 850;
			tf.height = 300;
			
			//tf.border = true;
			//tf.borderColor = 0xDAE2E8;
			//tf.background = true;
			//tf.backgroundColor = 0xFFFFFF;
			tf.border = false;
			tf.background = false;
			tf.embedFonts = false;
			var format:TextFormat = new TextFormat();
			format.font = "Tahoma";
			format.color = 0xFFFFFF;
			format.size = 11;
			
			tf.defaultTextFormat = format;
			addChild(tf);
			//stage.stageWidth
			tf.appendText("Init"+"\n");
			
			resize();
		}
		public function tr(s:String):void {
			tf.appendText(s);
		}
		private function resize(event:MouseEvent = null) : void {
			var vec : Graphics = box.graphics;
			vec.clear();
			
			vec.beginFill(0x000000, 0.5);
			if (!alp) {
				vec.drawRect(0, 0, 850, 300);
				tf.visible = true;
				alp = true;
			} else {
				vec.drawRect(0, 0, 850, 10);
				tf.visible = false;
				alp = false;
			}
			vec.lineStyle(1, 0xFFFFFF, 0.2);
				
			vec.endFill();
			
		}
	}

}