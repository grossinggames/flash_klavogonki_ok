package game.rooms.gameroom 
{
	import common.Common;
	import common.room.Room;
	import common.text.Textor;
	import common.text.TextGame;
	import game.rooms.GameRoom;
	import game.rooms.gameroom.TextBase;
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality; 
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ... Gospodin.Sorokin
	 */
	public class Rudder extends MovieClip
	{
		//[Embed(source = "../../../../lib/font/Turum2-Bold.ttf", fontFamily = "Turum", embedAsCFF = "false")]
		//[Embed(source="../../../../lib/font/arial.ttf", fontFamily = "Turum", embedAsCFF = "false")]
		[Embed(source="../../../../lib/font/bloggersans.ttf", fontFamily = "Turum", embedAsCFF = "false")]
		private var consolaFont			:Class;
		[Embed(source="../../../../lib/images/back.png")]
		private var _backClass			:Class;
		private var _timer    			:Timer;
		private var _arrayText			:Array;
		private var _itemText			:Array;
		private var _playersArray		:Array;
		private var _botArray1 			:Array;
		private var _botArray2 			:Array;
		private var _trackArr			:Array;
		private var _emptyArr			:Array 			= new Array;
		private var _textBase			:TextBase;
		private var _textSpeed			:TextField;
		private var _textError			:TextField;
		private var _textInput			:TextField;
		private var _currentNum			:int 			= 0;
		private var _endNum				:int 			= 0;
		private var _downPerSec			:int			= 0;
		private var _timerQuantity		:int 			= 0;
		private var _speedQuantity		:int 			= 0;
		private var _errorQuantity		:int			= 0;
		private var _point				:int 			= 0;
		private var _userSpeedSaver		:int 			= 0;
		private var _winStatus			:String;
		private var _errorSet			:Boolean 		= false;
		
		private var _countdownText		:Textor;
		private var _countdownTimer		:Timer;
		private var _countdownQuantity  :int;
		
		private var _finish				:Finish;
		private var _back 				:Sprite;
		
		public function Rudder() 
		{			
			_textBase = new TextBase;
			
			var _textInputFormat:TextFormat = new TextFormat();
			_textInputFormat.size = 25;
			_textInputFormat.font = "Turum";
			_textInputFormat.color = 0x000000;
			
			_textInput = new TextField;
			_textInput.x = 50;
			_textInput.y = 290;
			_textInput.width = 300;
			_textInput.height = 35;
			_textInput.border = true;
			_textInput.borderColor = 0x00FFFF;
			_textInput.embedFonts = true;
			_textInput.type = TextFieldType.INPUT;
			_textInput.defaultTextFormat = _textInputFormat;
			_textInput.setTextFormat(_textInputFormat);
			addChild(_textInput);
			
			var _emptyF:GlowFilter = new GlowFilter();
			_emptyF.color = 0x00BFBF; 
			_emptyF.alpha = 1;
			_emptyF.blurX = 4; 
			_emptyF.blurY = 4; 
			_emptyF.quality = BitmapFilterQuality.MEDIUM; 
			
			var _textErrorFormat:TextFormat = new TextFormat();
			_textErrorFormat.size = 45;
			_textErrorFormat.font = "Turum";
			_textErrorFormat.color = 0x80FFFF;
			
			_textError = new TextField;
			_textError.x = 618;
			_textError.y = 249;
			_textError.width = 100;
			_textError.embedFonts = true;
			_textError.selectable = false;
			_textError.filters = [_emptyF];
			_textError.defaultTextFormat = _textErrorFormat;
			_textError.setTextFormat(_textErrorFormat);
			addChild(_textError);
			
			var _textSpeedFormat:TextFormat = new TextFormat();
			_textSpeedFormat.size = 60;
			_textSpeedFormat.font = "Turum";
			_textSpeedFormat.color = 0x80FFFF;
			
			_textSpeed = new TextField;
			_textSpeed.x = 688;
			_textSpeed.y = 217;
			_textSpeed.width = 100;
			_textSpeed.embedFonts = true;
			_textSpeed.selectable = false;
			_textSpeed.filters = [_emptyF];
			_textSpeed.defaultTextFormat = _textSpeedFormat;
			_textSpeed.setTextFormat(_textSpeedFormat);
			addChild(_textSpeed);
			
			[Embed(source="../../../../lib/images/track_panel.png")]
			var trackPanel:Class;			
			
			for (var i:int = 0; i < 6; i++) {
				
				var track:Sprite = Common.createSpr( new _backClass() );
				track.x = 10;
				track.y = 430 + (i * 80);
				track.scaleX = 600;
				track.scaleY = 3;
				track.alpha = 0.5;
				addChild(track);
				
				var panel:Sprite = Common.createSpr( new trackPanel() );
				panel.x = 630;
				panel.y = 360 + (i * 80);
				//panel.scaleX = 150;
				//panel.scaleY = 70;
				//panel.alpha = 0.5;
				addChild(panel);
				
				var emptyText:Textor = new Textor("НЕТ СОПЕРНИКА", 20, 0xFF0000, true, 0x000000, false);
				emptyText.x = 640;
				emptyText.y = 380 + (i * 80);
				addChild(emptyText);
				_emptyArr.push(emptyText);
				
				
			}
		}
		//---------------------------------------------------------------------------------------
		//Создаем объекты
		public function startRace(players:Array):void {
			
			_playersArray = new Array;
			_itemText = new Array;
			var texxx:Array = _textBase.getText();
			var tex0:String = texxx[0]
			var tex1:String = texxx[1];
			
			_arrayText = tex0.split(" ");
			_arrayText.push(tex1);
			
			var jj:int = 0;
			var lengthLine:int = 50;
			var symbol:int = 11;
			_currentNum = 0;
			_endNum = _arrayText.length;
			
			var user:Boolean = true;
			
			for (var j:int = 0; j < players.length; j++) {
				var carAnimate:CarAnimate = new CarAnimate(this,user,players[j], _endNum,j,_userSpeedSaver);
				carAnimate.x = 0;
				carAnimate.y = 380 + (j * 80);
				addChild(carAnimate);
				_playersArray.push(carAnimate);
				_emptyArr[j].alpha = 0;
				user = false;
			}
			
			for (var i:int = 0; i < _endNum; i++) {
				_arrayText[i] += " ";
				var textGame:TextGame  = new  TextGame(_arrayText[i]);
				var tt:String
				textGame.x = lengthLine;
				textGame.y = 50 + jj;
				
				if (_endNum == i+1) {
					textGame.x = 200;
					textGame.y = 100+jj;
				} else {
					if (_endNum != i+1) {
						tt = _arrayText[i];
						lengthLine += (symbol * tt.length ) + symbol;
						tt = _arrayText[i + 1];
						var ii:int = (symbol * tt.length );
						if (lengthLine+ii > 750) {
							lengthLine = 50;
							jj += 25;
							tt = _arrayText[i];
							//textGame.x = 750 - (8 * tt.length);
						} 
					}
				}
				addChild(textGame);
				_itemText.push(textGame);
			}
			_textInput.addEventListener(KeyboardEvent.KEY_UP, keyDown_handler);
			_itemText[0].selectText(true);
			_errorQuantity = 0;
			_speedQuantity = 0;
			_timerQuantity = 0;
			_point = 0;
			_textSpeed.text = "000";
			_textError.text = "0";
			
			countdownRace();
		}
		//---------------------------------------------------------------------------------------
		//Обратный отсчет
		private function countdownRace():void {
			
			_back = Common.createSpr( new _backClass() );
			_back.x = 0;
			_back.y = 0;
			_back.scaleX = 800;
			_back.scaleY = 850;
			_back.alpha = 0.5;
			addChild(_back);
			
			_countdownText = new Textor("3", 80, 0xFFFFFF, true, 0xFF0000, true);
			_countdownText.x = 390;
			_countdownText.y = 250;
			_countdownText.scaleX = 0;
			_countdownText.scaleY = 0;
			addChild(_countdownText);
			
			_countdownQuantity = 0;
			
			_countdownTimer = new Timer(5);
			_countdownTimer.addEventListener(TimerEvent.TIMER, onTimerCountdown);
			_countdownTimer.start();
			Common.soundPlay("sfx_bib");
		}
		
		private function onTimerCountdown(e:TimerEvent):void {
			if (_countdownQuantity == 0) {
				if (_countdownText.scaleY >= 1 ) {
					_countdownText.replaceText("2");
					_countdownText.scaleX = 0;
					_countdownText.scaleY = 0;
					_countdownQuantity++;
					Common.soundPlay("sfx_bib");
				} else {
					_countdownText.scaleX += 0.015; 
					_countdownText.scaleY += 0.015;
				}
			} else if (_countdownQuantity == 1) {
				if (_countdownText.scaleY >= 1 ) {
					_countdownText.replaceText("1");
					_countdownText.scaleX = 0;
					_countdownText.scaleY = 0;
					_countdownQuantity++;
					Common.soundPlay("sfx_bib");
				} else {
					_countdownText.scaleX += 0.015; 
					_countdownText.scaleY += 0.015;
				}
			} else if (_countdownQuantity == 2) {
				if (_countdownText.scaleY >= 1 ) {
					_countdownText.replaceText("ПОЕХАЛИ!");
					_countdownText.scaleX = 0;
					_countdownText.scaleY = 0;
					_countdownText.x = 400;
					_countdownText.y = 250;
					_countdownQuantity++;
					Common.soundPlay("sfx_bib");
					//Common.soundPlay("sfx_start");
				} else {
					_countdownText.scaleX += 0.01; 
					_countdownText.scaleY += 0.01;
				}
			} else if (_countdownQuantity == 3) {
				if (_countdownText.scaleY >= 1 ) {
					_countdownQuantity++;
				} else {
					_countdownText.x -= 1.5;
					_countdownText.scaleX += 0.01; 
					_countdownText.scaleY += 0.01;
				}
			} else if (_countdownQuantity == 4) {
				if (_countdownText.alpha <= 0 ) {
					countdownRaceEnd();
				} else {
					_countdownText.alpha -= 0.1; 
					_back.alpha -= 0.05;
				}
			}
		}
		private function countdownRaceEnd():void {
			removeChild(_back);
			removeChild(_countdownText);
			_countdownTimer.stop();
			_countdownTimer.removeEventListener(TimerEvent.TIMER, onTimerCountdown);
			
			var ii:int = _playersArray.length;
			for (var i:int = 0; i < ii; i++) {
				_playersArray[i].starRace();
			}
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			_timer.start();
			stage.focus = _textInput;
		}
		//---------------------------------------------------------------------------------------
		//Конец игры
		private function finishGame():void {
			
			setComeCar();
			_textInput.text = "";
			//_textInput.type = TextFieldType.DYNAMIC;
			
			var raceResult:Array = new Array();
			raceResult[0] = _point;
			raceResult[1] = Math.round((_speedQuantity/_timerQuantity)*86);
			raceResult[2] = _errorQuantity;
			
			_finish = new Finish(this, raceResult);
			_finish.x = 0;
			_finish.y = 0;
			addChild(_finish);
		}
		
		public function endRace() : void {
			_textInput.removeEventListener(KeyboardEvent.KEY_UP, keyDown_handler);
			_timer.removeEventListener(TimerEvent.TIMER, onTimerHandler);
			_textError.x = 618;
			
			for (var j:int = 0; j < 6; j++) {;
				_emptyArr[j].alpha = 1;
			}
			for (var i:int = 0; i < _endNum; i++) {
				removeChild(_itemText[i]);
			}
			for (var n:int = 0; n < _playersArray.length; n++) {
				_playersArray[n].endRace();
				removeChild(_playersArray[n]);
			}
			removeChild(_finish);
			Common.switchRoom('MainRoom');
		}
		//---------------------------------------------------------------------------------------
		//Нажатия кнопочки
		private function keyDown_handler(event:KeyboardEvent):void {
			var tt:String = _arrayText[_currentNum];
			if (_textInput.text == tt) {
				_downPerSec++;
				currentTextSet();
			}   else if ( _textInput.text == tt.substr(0, _textInput.length) ) {
				_downPerSec++;
				if (_errorSet) {
					reErrorText();
				}
			} else {
				if (_errorSet == false) {
					_downPerSec++;
					errorText();
				}
			}
		}
		//---------------------------------------------------------------------------------------
		//Обработчик ошибки
		private function errorText():void {
			_errorSet = true;
			_errorQuantity++;
			_textError.text = _errorQuantity.toString();
			if (_errorQuantity > 99) {
				_textError.x = 592;
			} else if (_errorQuantity > 9) {
				_textError.x = 605;
			}
			
			_textInput.background = true;
			_textInput.backgroundColor = 0x00FFFF
			Common.soundPlay("sfx_error");
		}
		private function reErrorText():void {
			_errorSet = false;
			_textInput.background = false;
		}
		//---------------------------------------------------------------------------------------
		//Подсвечиваем текущее слово
		private function currentTextSet():void {
			Common.soundPlay("sfx_current");
			_textInput.text = "";
			_itemText[_currentNum].selectText(false);
			_currentNum++; 
			_playersArray[0].setBoost();
			if (_currentNum == _endNum-1) {
				finishGame();
			} else {
				_itemText[_currentNum].selectText(true);
			}
		}
		//---------------------------------------------------------------------------------------
		//Спидометр
		private function onTimerHandler(e:TimerEvent):void {
			stage.focus = _textInput;
			if (_downPerSec > 0) {
				_timerQuantity++;
				_speedQuantity += _downPerSec;
				_userSpeedSaver = (_speedQuantity / _timerQuantity) * 60;
				_downPerSec = (_speedQuantity / _timerQuantity) * 60;
				_textSpeed.text = _downPerSec.toString();
				_downPerSec = 0;
			}
		}
		//---------------------------------------------------------------------------------------
		//Анимация машинок
		
		public function setComeCar() : String {
			_point++;
			return _point.toString();
		}
		
		//private function raceCar():void {
		//	for(var i:int = 1; i < _botArray2.length; i++){
		//		_botArray2[i] = _botArray2[i] + 1;
		//		//trace(_botArray2[i]);
		//		if (_botArray1[i] == _botArray2[i]) {
		//			_botArray2[i] = 0;
		//			if (_playersArray[i].x < 650) {
		//				_playersArray[i].x = (_playersArray[i].x + (600 / _endNum));
		//			}
		//		}
		//	}
		//}
	}
}