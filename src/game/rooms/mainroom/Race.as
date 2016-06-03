package game.rooms.mainroom 
{
	/**
	 * ...
	 * @author baton
	 */
	import common.Common;
	import common.car.Car;
	import flash.display.Sprite;
	import flash.display.*;	
	import flash.events.MouseEvent;
	import flash.ui.*;
	
	public class Race extends Sprite
	{
		private var enterOver:Sprite;
		public var carList:Array = [];
		
		public function Race() 
		{

			// Спрайт войти
			[Embed(source = "../../../../lib/images/enter.png")] 
			var enterClass:Class;
			var enter:Sprite = Common.createSpr( new enterClass() );
            addChild(enter);
			// Активный спрайт войти
			[Embed(source = "../../../../lib/images/enter_over.png")] 
			var enterOverClass:Class;
			enterOver = Common.createSpr( new enterOverClass() );
			enterOver.alpha = 0;
			enter.addChild(enterOver);
			enter.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverEnter);
			enter.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutEnter);
			enter.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			function mouseDown(event:MouseEvent):void {
				//Common.switchRoom("GameRoom");
			}
			
			// Линия снизу заезда
			[Embed(source = "../../../../lib/images/line_race.png")] 
			var lineRaceClass:Class;
			var lineRace:Sprite = Common.createSpr( new lineRaceClass() );
			lineRace.x = 85;
			lineRace.y = 60;
			lineRace.scaleX = 650;
            addChild(lineRace);
			
			addCar();
		}
		
	    // Наведение на кнопку войти
		private function onMouseOverEnter(event:MouseEvent):void {
			Mouse.cursor = MouseCursor.BUTTON;
			enterOver.alpha = 1;
			//trace('onMouseOverEnter');
		}
		
		// Убрать курсор с кнопки войти
		private function onMouseOutEnter(event:MouseEvent):void {
			Mouse.cursor = MouseCursor.AUTO;
			enterOver.alpha = 0;
			//trace('onMouseOutEnter');
		}

		// Добавить машину в заезд
		public function addCar():int {
			var car:Car = Common.getCar();
			car.x = (carList.length * 115) + 80;
			this.addChild(car);
			carList.push(car);
			//trace('carList.length = ', carList.length);
			return carList.length;
		}
		
	}
}