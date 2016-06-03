package game.rooms.gameroom 
{
	import common.Common;
	import common.text.Textor;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.*;
	import flash.net.*;
	
	import common.net.WallPost;
	//import ru.inspirit.image.encoder.JPGEncoder;
	/**
	 * ...
	 * @author ... Gospodin.Sorokin
	 */
	public class Finish extends Sprite
	{
		private var _textWin			:Textor;
		private var _textSpeed			:Textor;
		private var _textError			:Textor;
		private var _back 				:Sprite;
		private var _backResult			:Sprite;
		private var _cancel				:Sprite;
		private var _share				:Sprite;
		private var _game 				:Rudder;
		private var _xx					:int		= 240;
		private var _yy					:int 		= 180;
		
		private var _raceResult			:Array;

		
		public function Finish(game:Rudder, raceResult:Array) 
		{
			_game = game;
			_raceResult = raceResult;
			
			[Embed(source = "../../../../lib/images/back.png")]
			var _backClass:Class;
			_back = Common.createSpr( new _backClass() );
			_back.x = 0;
			_back.y = 0;
			_back.scaleX = 800;
			_back.scaleY = 850;
			_back.alpha = 0.3;
			addChild(_back);
			
			[Embed(source="../../../../lib/images/finish_panel.png")]
			var backResultClass:Class;
			_backResult = Common.createSpr( new backResultClass() );
			_backResult.x = _xx;
			_backResult.y = _yy;
			addChild(_backResult);
			
			[Embed(source="../../../../lib/images/finish_panel_select.png")]
			var selectClass:Class;
			_share = Common.createSpr( new selectClass() );
			_share.x = _xx + 194;
			_share.y = _yy + 240;
			_share.alpha = 0;
			_share.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverGameCreateText);
			_share.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutGameCreateText);
			_share.addEventListener(MouseEvent.CLICK, endRace);
			_share.tabEnabled = false;
			addChild(_share);
			
			var cancelClass:Class;
			_cancel = Common.createSpr( new selectClass() );
			_cancel.x = _xx + 4;
			_cancel.y = _yy + 240;
			_cancel.alpha = 0;
			_cancel.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverGameCreateText);
			_cancel.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutGameCreateText);
			_cancel.addEventListener(MouseEvent.CLICK, shareRace);
			_cancel.tabEnabled = false;
			addChild(_cancel);
			
			_textWin = new Textor("Вы заняли " + raceResult[0] +" место", 37, 0xFFFFFF, true, 0x00AEAE, false);
			_textWin.x = _xx + 10;
			_textWin.y = _yy + 40;
			addChild(_textWin);
			
			_textSpeed = new Textor("Ваша скорость: "+raceResult[1]+" знаков в минуту", 23, 0x000000, false, 0xFF0000, false);
			_textSpeed.x = _xx + 10;
			_textSpeed.y = _yy + 90;
			addChild(_textSpeed);
			
			_textError = new Textor("Допущено ошибок: "+raceResult[2], 23, 0x000000, false, 0xFF0000, false);
			_textError.x = _xx + 10;
			_textError.y = _yy + 120;
			addChild(_textError);
		}
		private function endRace(e:MouseEvent):void {
			_share.removeEventListener(MouseEvent.CLICK, shareRace);
			_share.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverGameCreateText);
			_share.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutGameCreateText);
			_cancel.removeEventListener(MouseEvent.CLICK, endRace);
			_cancel.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverGameCreateText);
			_cancel.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutGameCreateText);
			Mouse.cursor = MouseCursor.AUTO;
			_game.endRace();
		}
		private function shareRace(e:MouseEvent):void {
			//Здесь мы типа в контакт все отправляем;
			//Common.wallPost(_raceResult);
			//addChild(new WallPost());
			Common.wp("EndRace",_raceResult);
			endRace(e);
		}
		
		private function onMouseOverGameCreateText(event:MouseEvent):void {
			Mouse.cursor = MouseCursor.BUTTON;
		}
		private function onMouseOutGameCreateText(event:MouseEvent):void {
			Mouse.cursor = MouseCursor.AUTO;
		}
	}
}