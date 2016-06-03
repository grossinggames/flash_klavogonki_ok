package game.rooms.mainroom 
{
	/**
	 * ...
	 * @author baton
	 */
	import common.Common;
	import flash.display.Sprite;
	import flash.display.*;	
	
	public class WaitPlayer extends Sprite
	{
		private var playerOn:Sprite;
		private var playerOff:Sprite;
		
		public function WaitPlayer() 
		{
			// Спрайт онлайн игрока
			[Embed(source = "../../../../lib/images/player_on.png")]
			var playerOnClass:Class;
			
			// Спрайт ожидания игрока
			[Embed(source = "../../../../lib/images/player_off.png")] 
			var playerOffClass:Class;
			
			playerOn = Common.createSpr( new playerOnClass() );
			playerOn.alpha = 0;
            addChild(playerOn);
			
			playerOff = Common.createSpr( new playerOffClass() );
			playerOff.alpha = 0;
            addChild(playerOff);
		}
		
		public function on():void
		{
			playerOn.alpha = 1;
			playerOff.alpha = 0;
		}

		public function off():void
		{
			playerOn.alpha = 0;
			playerOff.alpha = 1;
		}
		
	}

}