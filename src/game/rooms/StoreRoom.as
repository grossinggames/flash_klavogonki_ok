package game.rooms
{
	import common.car.Car;
	import common.room.Room;
	import common.*;
	import common.spr.Spr;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import game.rooms.storeroom.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.*;
	
	public class StoreRoom extends Room
	{	
		public var cars:Array = [
			[1,  2,  3,  4,  5 ],
			[6,  7,  8,  9,  10],
			[11, 12, 13, 14, 15],
			[16, 17, 18, 19, 20],
			[21, 22, 23, 24, 25],
			[26, 27, 28, 29, 30],
			[31, 32, 33, 34, 35],
			[36, 37, 38, 39, 40],
			[41],
		];
		
		private var carHub:Sprite = new Sprite;
		private var storeText:TextField;
		private var curCarText:TextField;
		private var exitText:TextField;
		private var allCars:Array = [];
		
		// Формат текста для надписи
		private var formatText:TextFormat = new TextFormat();
		
		public function StoreRoom()
		{
			createCars(); // Создать автомобили			
			createLayer(); // Добавить слой под меню
			createSlider(); // Создать слайдер
			createArrayCars(); // Создать и положить машины в массив
			setCurrentCar(); // Установить текущий автомобиль
			addTextStore(); // Добавить тексты Магазина
        }

		
		// Создать и положить машины в массив
		private function createArrayCars():void {
			for (var i:Number = 0; i < 41; i++) { 
				allCars.push( Common.getCar(i+1) );
				allCars[i].alpha = 0;
				allCars[i].x = 80;
				allCars[i].y = 35;
				addChild(allCars[i]);
			}
		}
		
		// Установить текущий автомобиль
		public function setCurrentCar():void {
			for (var i:Number = 0; i < 41; i++) { 
				allCars[i].alpha = 0;
			}
			allCars[ Common.carCur - 1 ].alpha = 1;
		}
		
		private function createLayer():void {
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(0xFFFFFF);
			spr.graphics.drawRect(0,0,800,150);
			spr.graphics.endFill();
			addChild(spr);
		}
		
		private function createSlider():void {
			var sliderHub:Sprite = new Sprite;
			sliderHub.x = 780;
			sliderHub.y = 170;
			addChild(sliderHub);
			
			// Добавили слайдер
			[Embed(source = "../../../lib/images/slider.png")] 
			var sliderClass:Class;
			var slider:Sprite = Common.createSpr( new sliderClass() );
			sliderHub.addChild(slider);
			slider.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverSlider);
			slider.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutSlider);
			slider.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownSlider);
			slider.addEventListener(MouseEvent.MOUSE_UP, onMouseUpSlider);

			// Добавили back слайдера
			[Embed(source = "../../../lib/images/back.png")] 
			var backScrollClass:Class;
			var backScroll:Sprite = Common.createSpr( new backScrollClass() );
			backScroll.scaleX = 800;
			backScroll.scaleY = 850;
			backScroll.alpha = 0;
			addChild(backScroll);
			backScroll.mouseEnabled = false;
			backScroll.addEventListener(MouseEvent.MOUSE_UP, onMouseUpSlider);
			
			function onMouseOverSlider(event:MouseEvent):void
			{
				//Mouse.cursor = MouseCursor.BUTTON;
			}
			function onMouseOutSlider(event:MouseEvent):void
			{
				//Mouse.cursor = MouseCursor.AUTO;
			}
			function onMouseDownSlider(event:MouseEvent):void 
			{
				//Mouse.cursor = MouseCursor.AUTO;
				slider.addEventListener(Event.ENTER_FRAME, onEnterFrameSlider);
				backScroll.mouseEnabled = true;
			}
			function onMouseUpSlider(e:Event):void
			{
				slider.removeEventListener(Event.ENTER_FRAME, onEnterFrameSlider);
				backScroll.mouseEnabled = false;
			}
			function onEnterFrameSlider(e:Event):void
			{
				var posY:Number = mouseY - sliderHub.y - 44;
				if (posY < 0) {
					posY = 0;
				} else if (posY > 500) {
					posY = 500;
				}
				slider.y = posY;

				var percent:Number = Math.floor(slider.y / 5);
				/*
				if (percent > 5) {
					storeText.alpha = 0;
					exitText.alpha = 0;
					exitText.mouseEnabled = false;
				} else if (percent < 5) {
					storeText.alpha = 1;
					exitText.alpha = 1;
					exitText.mouseEnabled = true;
				}
				*/
				// Чувствительность скрола
				var step:Number = -14;
				carHub.y = percent * step  + 200;
			}
		}
		
		private function addTextStore():void {
			// Формат текста для меню
			formatText.font = 'Arial';
			formatText.size = 18;
			formatText.color = 0x0099FF;
			
			// Надпись Гараж
			storeText = new TextField();
			storeText.text = 'Гараж';
			storeText.setTextFormat(formatText);
			storeText.width = 150;
			storeText.height = 30;
            storeText.x = 365;
			storeText.y = 50;
			storeText.selectable = false;
			addChild(storeText);
			
			// Надпись Гараж
			curCarText = new TextField();
			curCarText.text = 'Ваш автомобиль';
			curCarText.setTextFormat(formatText);
			curCarText.width = 150;
			curCarText.height = 30;
            curCarText.x = 70;
			curCarText.y = 100;
			curCarText.selectable = false;
			addChild(curCarText );

			// Надпись Выход
			exitText = new TextField();
			exitText.text = 'Выход';
			exitText.setTextFormat(formatText);
			exitText.width = 150;
			exitText.height = 30;
            exitText.x = 665;
			exitText.y = 50;
			exitText.selectable = false;
			addChild(exitText);
			exitText.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverExitText);
			exitText.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutExitText);
			exitText.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownExitText);
			function onMouseOverExitText(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.BUTTON;
			}
			function onMouseOutExitText(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.AUTO;
			}
			function mouseDownExitText(event:MouseEvent):void 
			{
				Common.switchRoom('MainRoom');
			}
		}
		
		private function createCars():void {
			addChild(carHub);
			carHub.x = 50;
			carHub.y = 200;
			
			for (var i:Number = 0; i < 9; i++) { 
				for (var j:Number = 0; j < 5; j++) {
					if (cars[ i ][ j ]) {
						cars[ i ][ j ] = new CarCell( Common.getCar(cars[ i ][ j ]), this );
						carHub.addChild(cars[ i ][ j ]);
						cars[ i ][ j ].x = j * 150;
						cars[ i ][ j ].y = i * 220;
					}
				}
			}
		}
		
		override public function open():void {
			trace('Class StoreRoom Open');
			trace( 'Common.buyCars() ' + Common.buyCars );
			
			setCurrentCar();
			
			for (var i:Number = 0; i < 9; i++) { 
				for (var j:Number = 0; j < 5; j++) {
					if (cars[ i ][ j ]) {
						//trace(cars[ i ][ j ].type + ":" + Common.buyCars[ cars[ i ][ j ].type - 1 ]);
						if (Common.buyCars[ cars[ i ][ j ].type - 1 ]==1)
						{
							cars[ i ][ j ].setSelect();
						}
					}
				}
			}
		}
	}
}