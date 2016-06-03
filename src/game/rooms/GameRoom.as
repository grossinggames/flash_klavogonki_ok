package game.rooms
{
	import flash.display.Sprite;
	import flash.events.Event;
	import common.room.Room;
	import common.Common;
	import game.rooms.gameroom.Rudder;
	
	import common.text.TextGame;
	
	public class GameRoom extends Room
	{	
		private var _rudder:Rudder;
		
		public function GameRoom()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			[Embed(source="../../../lib/images/control_panel.png")]
			var panelClass:Class;
			var panel:Sprite = Common.createSpr( new panelClass() );
			panel.x = 0;
			panel.y = 0;
			addChild(panel);
			
			_rudder = new Rudder();
			addChild(_rudder);
		}
		
		private function init(e:Event):void
		{
			//Common.carList
			//trace('Class GameRoom init');
			// Заглушчный код
			
			var _tempArr: Array = new Array();
			for (var i:int = 0; i < Math.round((Math.random() * 4) + 3); i++) {
				_tempArr.push(Math.round((Math.random() * 9) + 1));
			}
			//_tempArr = [[1], [5]];
			// После прочтения удалить
			_rudder.startRace(Common.cars);
		}
	}
}
