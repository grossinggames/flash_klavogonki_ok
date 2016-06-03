package common.p2p
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.LineScaleMode;
	
	/**
	 * ...
	 * @author baton
	 */
	public class User extends Sprite 
	{
		private static var RADIUS:int = 10;
		private var destinationX:int;
		private var destinationY:int;
		
		public function User() 
		{
			this.graphics.beginFill(Math.floor(Math.random() * (0xFFFFFF + 1)));
			this.graphics.lineStyle(1, 0, 1, false, LineScaleMode.NONE);
			this.graphics.drawCircle(RADIUS, RADIUS, RADIUS);
			this.graphics.endFill();
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function moveTo (xVal:int, yVal:int):void
		{
			destinationX = xVal;
			destinationY = yVal;
		}
		
		private function enterFrameHandler (event:Event):void
		{
			this.x -= (this.x - destinationX) * 0.2;
			this.y -= (this.y - destinationY) * 0.2;
		}
	}
}