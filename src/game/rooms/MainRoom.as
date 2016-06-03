package game.rooms
{
	import flash.display.*;	
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.ui.*;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.events.KeyboardEvent;
	import common.room.Room;
	import flash.display.Sprite;
	import common.Common;
	import game.rooms.mainroom.Race;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
	import game.rooms.mainroom.WaitPlayer;
	import common.sound.SoundButtons;
	
	public class MainRoom extends Room
	{	
		// Массив игр
		private var raceList:Array = [];
		private var raceStepY:Number = 70;
		private var raceTotal:Number = 5;	
		private var loadingHub:Sprite;
		private var soundButtons:SoundButtons;
		
		// Формат текста для надписи готовы
		private var formatReadyText:TextFormat = new TextFormat();

		private var formatText:TextFormat = new TextFormat();
		
		//  Таймер для добавления поиска нового клиента для заезда
		private var addNewPlayeTimer:Timer = new Timer(2500);

		public function MainRoom()
		{
			// Добавить кнопки звуков
			function addSoundButton():void
			{
				soundButtons = new SoundButtons();
				soundButtons.x = 700;
				soundButtons.y = 10;
				addChild(soundButtons);
			}
		
			// Установить формат
			function setFormat():void
			{
				// Формат текста для меню
				formatText.font = 'Arial';
				formatText.size = 18;
				
				// Формат текста для надписи готовы
				formatReadyText.font = 'Arial';
				formatReadyText.size = 16;
				formatReadyText.color = 0xFFFFFF;
			}

			// Добавить меню
			function addMenu():void
			{
				/* Быстрый страт */
				// Колесо
				[Embed(source = "../../../lib/images/wheel.png")] 
				var wheelClass:Class;
				var wheel:Sprite = Common.createSpr( new wheelClass() );
				wheel.x = 10;
				wheel.y = 10;
				addChild(wheel);
				wheel.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverWheelText);
				wheel.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutWheelText);
				wheel.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				
				// Быстрый старт
				var wheelText:TextField = new TextField();
				wheelText.text = 'Быстрый старт';
				wheelText.setTextFormat(formatText);
				wheelText.width = 150;
				wheelText.height = 30;
				wheelText.x = 60;
				wheelText.y = 220;
				//addChild(wheelText);
				wheelText.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverWheelText);
				wheelText.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutWheelText);
				wheelText.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				function onMouseOverWheelText(event:MouseEvent):void
				{
					Mouse.cursor = MouseCursor.BUTTON;
				}
				function onMouseOutWheelText(event:MouseEvent):void
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				function mouseDown(event:MouseEvent):void 
				{
					/* Послать количество машин */
					Common.cars = [Common.carCur];
					waitPlayers(Common.cars.length);
				}

				/* Список игр */
				/*
				[Embed(source = "../../../lib/images/icon-gamelist.gif")] 
				var gamelistClass:Class;
				var gamelist:Sprite = Common.createSpr( new gamelistClass() );
				gamelist.x = 310;
				gamelist.y = 10;
				addChild(gamelist);
				gamelist.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverGameListText);
				gamelist.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutGameListText);
						
				// Выбрать заезд
				var gamelistText:TextField = new TextField();
				gamelistText.text = 'Выбрать заезд';
				gamelistText.setTextFormat(formatText);
				gamelistText.width = 150;
				gamelistText.height = 30;
				gamelistText.x = 350;
				gamelistText.y = 220;
				addChild(gamelistText);
				gamelistText.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverGameListText);
				gamelistText.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutGameListText);
				function onMouseOverGameListText(event:MouseEvent):void
				{
					Mouse.cursor = MouseCursor.BUTTON;
				}
				function onMouseOutGameListText(event:MouseEvent):void
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				*/
				
				/* Гараж */
				[Embed(source = "../../../lib/images/garage.png")] 
				var gamecreateClass:Class;
				var gamecreate:Sprite = Common.createSpr( new gamecreateClass() );
				gamecreate.x = 470;
				gamecreate.y = 10;
				addChild(gamecreate);
				gamecreate.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				gamecreate.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
				gamecreate.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				
				// Гараж
				var gamecreateText:TextField = new TextField();
				gamecreateText.text = 'Гараж';
				gamecreateText.setTextFormat(formatText);
				gamecreateText.width = 150;
				gamecreateText.height = 30;
				gamecreateText.x = 645;
				gamecreateText.y = 220;
				//addChild(gamecreateText);
				gamecreateText.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				gamecreateText.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				gamecreateText.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				
				/* Друзья */
				[Embed(source = "../../../lib/images/friend.png")] 
				var friendClass:Class;
				var friend:Sprite = Common.createSpr( new friendClass() );
				friend.x = 240;
				friend.y = 10;
				addChild(friend);
				
				friend.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				friend.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
				
			}
			
			// Добавить заезды
			function addGameList():void 
			{
				/* Контейнер списока игр */
				var gameListHub:Sprite = new Sprite;
				gameListHub.x = 30;
				gameListHub.y = 250;
				addChild(gameListHub);

				function enterRace(event:MouseEvent):void 
				{
					for (var i:int = 0; i < raceList.length; i++) 
					{
						if (event.currentTarget == raceList[i]) 
						{
							/* Послать количество машин */
							var countCarsInRace:int = raceList[i].carList.length;
							Common.cars = [Common.carCur];
							
							for (var j:int = 0; j < countCarsInRace; j++) 
							{
								Common.cars[j + 1] = raceList[i].carList[j].type;
							}
							
							waitPlayers(countCarsInRace + 1);
							removeRace(i);
							break;
						}
					}
				}
				
				// Метод добавления заезда
				// Первым делом нужно брать из кучи удаленных заездов что бы не создавать новые заезды а брать старые
				function addRace():void 
				{
					//var isAddRace:int = randomInt(0, 1);
					var isAddRace:int = 1;
					
					if ( isAddRace && (raceList.length < raceTotal) ) 
					{
						var newRace:Race = new Race;
						raceList.push(newRace);
						
						var raceIndex:Number = raceList.length - 1;
						raceList[raceIndex].y = 0;
						raceList[raceIndex].addEventListener(MouseEvent.MOUSE_DOWN, enterRace);
						raceList[raceIndex].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
						raceList[raceIndex].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
						//raceList[raceIndex].y = raceStepY;
						gameListHub.addChild( raceList[raceIndex] );
						if (Common.currentRoom == "MainRoom") {
							Common.soundPlay("sfx_current");
						}
					}
				}

				// Метод удаления заезда
				// Первым делом необходимо добавить занесение удаленных игр в общую кучу для того что бы потом брать из нее при создании нового заезда
				function removeRace(numRace:Number):void 
				{
					if (raceList.length) 
					{
						// Рендомно выбираем заезд для удаления
						//var raceIndex:Number = getRaceRandom();
						
						var raceIndex:Number = numRace;
						gameListHub.removeChild( raceList[raceIndex] );
						//trace('Remove index ', raceIndex);
						raceList.splice(raceIndex, 1);
					}
				}
				
				// Получить случайный индекс в массиве
				function getRaceRandom():Number 
				{
					var raceIndex:Number = 0;
					var raceTotal:Number = raceList.length - 1;
					raceIndex = randomInt(raceIndex, raceTotal);
					return raceIndex;
				}
				
				//  Таймер для добавления машины в заезд
				var addCarTimer:Timer = new Timer(1000);
				addCarTimer.addEventListener("timer", addCarTimerHandler);
				addCarTimer.start();
				
				function addCarTimerHandler(event:TimerEvent):void 
				{
					if (raceList.length) {
						var isAdd:int = randomInt(0, 1);
						
						if (isAdd) 
						{
							var randomRace:int = randomInt(0, (raceList.length - 1) );
							//trace('randomRace = ', randomRace);
							
							if (raceList[randomRace]) 
							{
								var raceCountCar:int = raceList[randomRace].addCar();
								
								if ( raceCountCar >= 5 || (randomInt(0, 100) < 10 ) ) 
								{
									removeRace(randomRace);
									if (Common.currentRoom == "MainRoom") 
									{
										Common.soundPlay("sfx_error");
									}
								} 
								else 
								{
									if (Common.currentRoom == "MainRoom") 
									{
										Common.soundPlay("sfx_current");
									}
								}
							}
						}
					}
				}
				
				// Таймер для добавления и удаления заезда
				var raceTimer:Timer = new Timer(3000);
				raceTimer.addEventListener("timer", raceTimerHandler);
				raceTimer.start();
				
				// Обработчик на таймер
				function raceTimerHandler(event:TimerEvent):void 
				{
					//trace("timerHandler");
					//var isAddRace:Number = 1;
					
					// Только добавляем заезды
					var isAddRace:Number = randomInt(1, 30);
					
					if ( (isAddRace > 9 && isAddRace < 11) || (raceList.length > 5) ) 
					{
						isAddRace = 0;
					}
					
					// Если количество заездов меньше 4, принудительно создаем заезд
					if (raceList.length < 4) 
					{
						isAddRace = 1;
					}
					
					/*
					if ( isAddRace && (raceList.length < raceTotal) ) 
					{
						addRace();
						trace('Add');
					}
					*/
					
					
					// Если добавляем
					if ( isAddRace && (raceList.length < raceTotal) ) 
					{
						addRace();
						//trace('Add');
					} 
					else if (raceList.length > 1 && isAddRace == 0) 
					{
						var randomRace:int = randomInt( 0, (raceList.length - 1) );
						removeRace(randomRace);
						//trace('Remove');
					}
					
				}
				
				// Создаем заезды по умолчанию
				var countCrateRace:int = randomInt(3, 15);
				//trace('countCrateRace = ', countCrateRace);
				if (countCrateRace) 
				{
					for (var raceIndex:int = 0; raceIndex < countCrateRace; raceIndex++) 
					{
						addRace();
					}
				}
			}

			function onMouseOver(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.BUTTON;
			}
			function onMouseOut(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.AUTO;
			}
			function onMouseDown(event:MouseEvent):void
			{
				Common.switchRoom('StoreRoom');
			}

			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			addSoundButton();
			setFormat();
			addMenu();
			addGameList();
		}

		// Рендомное число типа int
		private function randomInt(min:Number, max:Number):Number 
		{
			var rand:Number = min + Math.random() * (max + 1 - min);
			rand = Math.floor(rand);
			return rand;
		}
		
		// Анимация ожидания игроков
        private function waitPlayers(countCars:Number):void 
		{
			// Контейнер ожидания
			var wait:Sprite = new Sprite();
			addChild(wait);
			
			// Задний фон
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0);
			bg.graphics.drawRect(0, 0, 800, 850);
			bg.graphics.endFill();
			bg.alpha = 0.2;
			wait.addChild(bg);
			
			// Спрайт карты
			[Embed(source = "../../../lib/images/map.png")] 
			var mapClass:Class;
			var map:Sprite = Common.createSpr( new mapClass() );
			map.x = 100;
			map.y = 265;
            wait.addChild(map);
			
			// Анимация ожидания
			loadingHub = new Sprite;
			loadingHub.x = 320;
			loadingHub.y = 280;
            wait.addChild(loadingHub);
			[Embed(source = "../../../lib/images/350.png")] 
			var loadingClass:Class;
			var loading:Sprite = Common.createSpr( new loadingClass() );
			loading.x = -10;
			loading.y = -10;
            loadingHub.addChild(loading);
			
			// Отмена ожидания
			[Embed(source = "../../../lib/images/cancel.png")] 
			var cancalRaceClass:Class;
			var cancalRace:Sprite = Common.createSpr( new cancalRaceClass() );
			cancalRace.x = 680;
			cancalRace.y = 240;
			cancalRace.addEventListener(MouseEvent.MOUSE_DOWN, onCancelRace);
			cancalRace.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverCancalRace);
			cancalRace.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutCancalRace);
			wait.addChild(cancalRace);
			function onMouseOverCancalRace(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.BUTTON;
			}
			function onMouseOutCancalRace(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.AUTO;
			}
			function onCancelRace():void 
			{
				addNewPlayeTimer.removeEventListener("timer", addNewPlayerHandler);
				addNewPlayeTimer.stop();
				removeChild(wait);
			}
			
			// Спрайт на ожидание игроков
			var player1:WaitPlayer =  new WaitPlayer;
			player1.x = 325;
			player1.y = 400;
			player1.on();
            wait.addChild(player1);
			
			var player2:WaitPlayer =  new WaitPlayer;
			player2.x = 360;
			player2.y = 400;
			player2.off();
            wait.addChild(player2);
			
			var player3:WaitPlayer =  new WaitPlayer;
			player3.x = 395;
			player3.y = 400;
			player3.off();
            wait.addChild(player3);
			
			var player4:WaitPlayer =  new WaitPlayer;
			player4.x = 430;
			player4.y = 400;
			player4.off();
            wait.addChild(player4);
			
			var player5:WaitPlayer =  new WaitPlayer;
			player5.x = 465;
			player5.y = 400;
			player5.off();
            wait.addChild(player5);
			
			//var player6:WaitPlayer =  new WaitPlayer;
			//player6.x = 480;
			//player6.y = 400;
			//player6.off();
            //wait.addChild(player6);

			var findPlayerCurr:int = countCars;			
			addNewPlayeTimer.addEventListener("timer", addNewPlayerHandler);

			for (var i:int = 1; i <= findPlayerCurr; i++) 
			{
				switch (i) { 
					case 1: 
						player1.on();
						break; 
					case 2: 
						player2.on();
						break;
					case 3: 
						player3.on();
						break;
					case 4: 
						player4.on();
						break;
					case 5: 
						player5.on();
						break;
					//case 6: 
					//	player6.on();
					//	break;
				}
			}
			
			// Надпись готовы
			var readyText:TextField = new TextField();
			readyText.text = 'Готовы: ' + findPlayerCurr + '/5';
			readyText.setTextFormat(formatReadyText);
			readyText.width = 150;
			readyText.height = 30;
            readyText.x = 360;
			readyText.y = 430;
			readyText.selectable = false;
			wait.addChild(readyText);

			// Надпись ожидание
			var waitText:TextField = new TextField();
			waitText.text = 'Ожидание игроков';
			waitText.setTextFormat(formatReadyText);
			waitText.width = 200;
			waitText.height = 30;
            waitText.x = 339;
			waitText.y = 270;
			waitText.selectable = false;
			wait.addChild(waitText);
			
			// Добавление изображения нового пользователя на карте
			[Embed(source = "../../../lib/images/player_on.png")] 
			var playerClass:Class;
			// Добавление изображения нового пользователя на карте
			var playerMap2:Sprite = Common.createSpr( new playerClass() );
			playerMap2.scaleX = 0.5;
			playerMap2.scaleY = 0.5;
			playerMap2.x = 100;
			playerMap2.y = 265;
			playerMap2.alpha = 0;
			wait.addChild(playerMap2);
			
			// Добавление изображения нового пользователя на карте
			var playerMap3:Sprite = Common.createSpr( new playerClass() );
			playerMap3.scaleX = 0.5;
			playerMap3.scaleY = 0.5;
			playerMap3.x = 100;
			playerMap3.y = 265;
			playerMap3.alpha = 0;
			wait.addChild(playerMap3);
			
			// Добавление изображения нового пользователя на карте
			var playerMap4:Sprite = Common.createSpr( new playerClass() );
			playerMap4.scaleX = 0.5;
			playerMap4.scaleY = 0.5;
			playerMap4.x = 100;
			playerMap4.y = 265;
			playerMap4.alpha = 0;
			wait.addChild(playerMap4);
			
			// Добавление изображения нового пользователя на карте
			var playerMap5:Sprite = Common.createSpr( new playerClass() );
			playerMap5.scaleX = 0.5;
			playerMap5.scaleY = 0.5;
			playerMap5.x = 100;
			playerMap5.y = 265;
			playerMap5.alpha = 0;
			wait.addChild(playerMap5);
			
			// Добавление изображения нового пользователя на карте
			/*
			var playerMap6:Sprite = Common.createSpr( new playerClass() );
			playerMap6.scaleX = 0.5;
			playerMap6.scaleY = 0.5;
			playerMap6.x = 100;
			playerMap6.y = 265;
			playerMap6.alpha = 0;
			wait.addChild(playerMap6);
			*/
			
			function addPeople():void 
			{
				for (var i:int = 1; i <= findPlayerCurr; i++) 
				{
					switch (i) { 
						case 2: 
							if (!playerMap2.alpha) {
								playerMap2.x = randomInt(400, 560);
								playerMap2.y = randomInt(315, 390);
								playerMap2.alpha = 1;
							}
							break;
						case 3: 
							if (!playerMap3.alpha) {
								playerMap3.x = randomInt(400, 560);
								playerMap3.y = randomInt(315, 390);
								playerMap3.alpha = 1;
							}
							break;
						case 4: 
							if (!playerMap4.alpha) {
								playerMap4.x = randomInt(400, 560);
								playerMap4.y = randomInt(315, 390);
								playerMap4.alpha = 1;
							}
							break;
						case 5: 
							if (!playerMap5.alpha) {
								playerMap5.x = randomInt(400, 560);
								playerMap5.y = randomInt(315, 390);
								playerMap5.alpha = 1;
							}
							break;
					}
				}
			}

			addPeople();
			
			function addNewPlayerHandler():void 
			{
				if (findPlayerCurr < 5) 
				{
					Common.cars[findPlayerCurr] = randomInt(1, 10);
				}
				
                findPlayerCurr++;
				switch (findPlayerCurr) 
				{ 
					case 1: 
						player1.on();
						break; 
					case 2: 
						player2.on();
						playerMap2.x = randomInt(400, 560);
						playerMap2.y = randomInt(315, 390);
						playerMap2.alpha = 1;
						break; 
					case 3: 
						player3.on();
						playerMap3.x = randomInt(400, 560);
						playerMap3.y = randomInt(315, 390);
						playerMap3.alpha = 1;
						break; 
					case 4: 
						player4.on();
						playerMap4.x = randomInt(400, 560);
						playerMap4.y = randomInt(315, 390);
						playerMap4.alpha = 1;
						break; 
					case 5: 
						player5.on();
						playerMap5.x = randomInt(400, 560);
						playerMap5.y = randomInt(315, 390);
						playerMap5.alpha = 1;
						break; 
					case 6: 
						/*
						player6.on();
						playerMap6.x = randomInt(400, 560);
						playerMap6.y = randomInt(315, 390);
						playerMap6.alpha = 1;
						addNewPlayeTimer.delay = 500;
						break; 
						*/
						addNewPlayeTimer.removeEventListener("timer", addNewPlayerHandler);
						addNewPlayeTimer.stop();
						waitPlayersHide();
						trace(Common.cars);
						break; 
					case 7: 
						/*
						addNewPlayeTimer.removeEventListener("timer", addNewPlayerHandler);
						addNewPlayeTimer.stop();
						waitPlayersHide();
						trace(Common.cars);
						break; 
						*/
					default : 
						//trace("switch default"); 
				}
				
				readyText.text = 'Готовы: ' + findPlayerCurr + '/5';
				readyText.setTextFormat(formatReadyText);
					
				if ( (findPlayerCurr > 1) && randomInt(0, 8) < 3 ) 
				{
					addNewPlayeTimer.delay = 1000;
					findPlayerCurr = 5;
				} 
				else 
				{
					if (findPlayerCurr < 5) {
						var delay:int = randomInt(500, 3000);
						addNewPlayeTimer.delay = delay;
					}
				}
			}
			
			// Скрыть анимацию ожидания игроков
			function waitPlayersHide():void 
			{
				removeChild(wait);
				Common.soundStopAll();
				Common.switchRoom("GameRoom");
			}
			
			addNewPlayeTimer.start();
        }
		
        public function enterFrameHandler(event:Event):void 
		{
			// Расстановка заездов по строкам
			for (var raceIndex:int = 0, raceTotal:int = raceList.length; raceIndex < raceTotal; raceIndex++) 
			{
                var newPosY:Number = ( ( (raceTotal - raceIndex) * raceStepY) - raceList[raceIndex].y ) * 0.1;
				raceList[raceIndex].y += newPosY;
			}
			
			if (loadingHub) 
			{
				loadingHub.rotation += 15;
				
				if (loadingHub.rotation > 360) 
				{
					loadingHub.rotation -= 360;
				}
			}
        }

		private function init(e:Event):void
		{
			//trace('Class MainRoom init');
		}

		override public function open():void 
		{
			//trace('Class MainRoom Open');
			soundButtons.update();
		}
	}
}