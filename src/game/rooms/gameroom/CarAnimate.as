package game.rooms.gameroom 
{
	import common.text.Textor;
	import common.car.Car;
	import common.Common;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer; 
	/**
	 * ...
	 * @author ...
	 */
	public class CarAnimate extends MovieClip 
	{
		private var _speedText			:Textor;
		private var _errorText			:Textor;
		private var _speedLabel			:Textor;
		private var _errorLabel			:Textor;
		private var _game 				:Rudder;
		private var _user 				:Boolean;
		private var _carNum 			:int;
		private var _lengthRace 		:int;
		private var _indexCar 			:int;
		private var _race				:Number;
		private var _car 				:Car;
		private var _timerUser 			:Timer;
		private var _timerBot			:Timer;
		private var _countdownBot		:int;
		private var _countdownBot2		:int;
		private var _lengthBot			:int;
		private var _errorBot			:int;
		private var _errorBot2			:int;
		private var _speedBot			:int;
		private var _alpBot				:int			= -1;
		private var _botEvent			:String;  //  start_leave - Покинул игру при старте |leave - покинул игру| mass_error - повышенное колличество ошибок| null_error - без ошибок| boost_speed - увеличенная скорость| decrease_speed - уменьшенная скорость| null_speed - нулевая скорость| 
		private var _botEventArr		:Array 			=[["null"],["one_error"],["leave"],["mass_error"],["null_error"],["boost_speed"],["decrease_speed"],["null_speed"]]
		
		
		public function CarAnimate(_game:Rudder, _user:Boolean, _carNum:int, _lengthRace:int, _indexCar:int, _userSpeed:int) 
		{
			this._game = _game;
			this._user = _user;
			this._carNum = _carNum;
			this._lengthRace = (Math.floor((500/_lengthRace)*10))/10;
			this._indexCar = _indexCar;
			_lengthBot = _lengthRace;
			
			_car = Common.getCar(_carNum)//new Car(_carNum);
			addChild(_car);
			if (_indexCar == 0) {	
				var userText:Textor = new Textor("ЭТО ВЫ", 35, 0xFF0000, true, 0x808080, false);
				userText.x = 650;
				userText.y = -10;
				addChild(userText);
			} else {
				if (_userSpeed == 0) {				
					_speedBot = Math.round(Math.random() * 10)+15;
				} else if (_userSpeed > 0 && _userSpeed < 250) {
					_speedBot = Math.round(Math.random() * 5)+20;
				} else if (_userSpeed > 249 && _userSpeed < 400) {
					_speedBot = Math.round(Math.random() * 10)+15;
				} else if (_userSpeed > 399 && _userSpeed < 600) {
					_speedBot = Math.round(Math.random() * 15)+10;
				} else if (_userSpeed > 599 && _userSpeed < 1000) {
					_speedBot = Math.round(Math.random() * 20)+5;
				}
				//_errorBot = Math.round(Math.random() * 70);
				_countdownBot = 0;
				
				_speedLabel = new Textor("Скорость", 15, 0x000000, true, 0x00FFFF, false);
				_speedLabel.x = 645;
				_speedLabel.y = -18;
				addChild(_speedLabel);
					
				_errorLabel = new Textor("Ошибки", 15, 0x000000, true, 0x00FFFF, false);
				_errorLabel.x = 715;
				_errorLabel.y = -18;
				addChild(_errorLabel);
				
				_speedText = new Textor("000", 30, 0x00FFFF, true, 0x009191, true);
				_speedText.x = 650;
				_speedText.y = 0;
				addChild(_speedText);
				
				_errorText = new Textor("0", 30, 0x00FFFF, true, 0x009191, true);
				_errorText.x = 730;
				_errorText.y = 0;
				addChild(_errorText);
			}
		}
		
		public function starRace():void {
			_race = 50;
			botEventGener();
			_timerUser = new Timer(100);
			_timerUser.addEventListener(TimerEvent.TIMER, onTimerHandlerUser);
			_timerUser.start();
		}
		
		public function endRace():void {
			_timerUser.removeEventListener(TimerEvent.TIMER, onTimerHandlerUser);
			_timerUser.stop();
		}
		
		private function botEventGener():void {
			var sun:int = Math.round(Math.random() * 5000);
			if (sun >= 500 && sun <= 750) {
				_botEvent = _botEventArr[1];
			} else if (sun >= 470 && sun <= 471) {
				_botEvent = _botEventArr[2];
			} else if (sun >= 240 && sun <= 241) {
				_botEvent = _botEventArr[3];
			} else if (sun >= 350 && sun <= 351) {
				_botEvent = _botEventArr[4];
			} else if (sun >= 330 && sun <= 331) {
				_botEvent = _botEventArr[5];
			} else if (sun >= 150 && sun <= 151) {
				_botEvent = _botEventArr[6];
			} else if (sun >= 110 && sun <= 111) {
				_botEvent = _botEventArr[7];
			} else {
				_botEvent = _botEventArr[0];
			}
		}
		
		private function onTimerHandlerUser(e:TimerEvent):void {
			//Бот евенты
			if (_user == false && _alpBot == -1) {
				//if (_errorBot2 >= 10 && _race == 0) {
				//	_botEvent = _botEventArr[2];
				//}
				
				if (_botEvent == _botEventArr[1]) {
					_errorBot2++;
					_countdownBot -= 2;
					setError(_errorBot2.toString());
					botEventGener();
				} else if (_botEvent == _botEventArr[2]) {
					stopBot();
				} else if (_botEvent == _botEventArr[3]) {
					if ( 8 < Math.round(Math.random() * 10)) {
						_errorBot2++;
						_countdownBot -= 2;
						setError(_errorBot2.toString());
					}
				} else if (_botEvent == _botEventArr[4]) {
					
				} else if (_botEvent == _botEventArr[5]) {
					_speedBot = Math.round(Math.random() * 10)+5
					botEventGener();
				} else if (_botEvent == _botEventArr[6]) {
					_speedBot = Math.round(Math.random() * 10)+15
					botEventGener();
				} else if (_botEvent == _botEventArr[7]) {
					_speedBot = 0;
					_race = 0;
				} else {
					botEventGener();
				}
				
				_countdownBot++;
				if (_car.x > 500) {
					stopBot();
				} else {
					if (_speedBot == _countdownBot) {
						_countdownBot = 0;
						setBoost();
					}
					if (_race == 0) {
						setSpeed("000");
					} else {	
						setSpeed( (((26 - _speedBot) * 35) + Math.round(Math.random() * 25)).toString() );
					}
				}
			}
			//Движение машины
			if (_race > 0 && _alpBot==-1) {			
				if (_race >= 150) {
					_car.x += 6;
					_race -= 6;
				} else if (_race >= 100) {
					_car.x += 5;
					_race -= 5;
				} else if (_race >= 75) {
					_car.x += 4;
					_race -= 4;
				} else if (_race >= 50) {
					_car.x += 3;
					_race -= 3;
				} else if (_race >= 25) {
					_car.x += 2;
					_race -= 2;
				} else if (_race >= 10) {
					_car.x += 1;
					_race -= 1;
				} else if (_race >= 5) {
					_car.x += 0.5;
					_race -= 0.5;
				} else if (_race < 5) {
					_car.x += 0.2;
					_race -= 0.2;
				}
			} else {
				_race = 0;
			}
			//Затемнение
			if (_alpBot > -1 ) {
				if (_alpBot == 0 ) {
					_car.alpha -= 0.05;
					if (_car.alpha <= 0.3) {
						endRace();
					}
				} else {
					_alpBot--;
				}
			}
		}
		
		private function onTimerHandlerBot(e:TimerEvent):void {
			
		}
		
		private function stopBot():void {
			//endRace();
			_alpBot = Math.round(Math.random() * 120)+30;
			_race = 0;
			if (_botEvent != "leave") {
				_speedLabel.alpha = 0;
				_errorLabel.alpha = 0;
				_speedText.alpha = 0;
				_errorText.alpha = 0;
				var winText:Textor = new Textor(_game.setComeCar(), 60, 0xFF0000, true, 0x808080, true);
				winText.x = 685;
				winText.y = -28;
				addChild(winText);
			}
		}
		
		public function setBoost():void {
			_race += _lengthRace;
		}
		public function setSpeed(speed:String):void {
			_speedText.replaceText(speed);
		}
		public function setError(error:String):void {
			_errorText.replaceText(error);
		}
	}

}