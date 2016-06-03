package game.rooms.storeroom 
{
	import common.car.Car;
	import common.Common;
	import flash.ui.*;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import game.rooms.StoreRoom;
	import common.gavanna.Shop;
	import common.gavanna.Gavanas;
	import common.events.AppGavannaEvent;
	/**
	 * ...
	 * @author baton; Gospodin.Sorokin
	 */
	public class CarCell extends Sprite
	{
		public var type:Number = 0;
		private var description:String = "Название машины по умолчанию";
		private var price:int = 0;
		private var selectCar:Sprite;
		private var selectOffCar:Sprite;
		private var buyCar:Sprite;
		private var carText:TextField = new TextField();
		private var room:StoreRoom;
		private var shop:Shop;
		
		public function CarCell(car:Car, scene:StoreRoom) 
		{
			room = scene;
			
			// Добавить машину в отображение
			type = car.type;
			description = car.description;
			price = car.price;
			
			addChild(car);
			addNameCar();
			addPriceCar();
			addBuyCar();
		}
		
		private function addNameCar():void {
			// Формат текста
			var formatText:TextFormat = new TextFormat();
			formatText.font = 'Arial';
			formatText.size = 13;
			formatText.bold = true;
			
			var carText2:TextField = new TextField();
			carText2.text = description;
			carText2.setTextFormat(formatText);
			carText2.width = 150;
			carText2.height = 60;
            carText2.x = 5;
			carText2.y = -30;
			carText2.selectable = false;
			addChild(carText2);
		}
		
		private function addPriceCar():void {
			// Формат текста
			var formatText:TextFormat = new TextFormat();
			formatText.font = 'Arial';
			formatText.size = 14;
			
			carText.text = price + " Голосов";
			if (price < 1) 
			{
				//carText.text = "  Бесплатно";
				carText.text = "";
			}
			carText.setTextFormat(formatText);
			carText.width = 150;
			carText.height = 30;
            carText.x = 10;
			carText.y = 55;
			carText.selectable = false;
			addChild(carText);
		}

		private function addBuyCar():void {
			/* Купить */
			[Embed(source = "../../../../lib/images/select.png")] 
			var selectCarClass:Class;
			selectCar = Common.createSpr( new selectCarClass() );
			selectCar.x = 20;
			selectCar.y = 90;
			selectCar.mouseEnabled = false;
			selectCar.alpha = 0;
			addChild(selectCar);
			selectCar.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBuyCar);
			selectCar.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutBuyCar);
			selectCar.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownBuyCar);
			
			[Embed(source = "../../../../lib/images/select_off.png")] 
			var selectOffCarClass:Class;
			selectOffCar = Common.createSpr( new selectOffCarClass() );
			selectOffCar.x = 20;
			selectOffCar.y = 90;
			selectOffCar.mouseEnabled = false;
			selectOffCar.alpha = 0;
			addChild(selectOffCar);
			
			[Embed(source = "../../../../lib/images/buy.png")] 
			var buyCarClass:Class;
			buyCar = Common.createSpr( new buyCarClass() );
			buyCar.x = 20;
			buyCar.y = 90;
			buyCar.mouseEnabled = false;
			buyCar.alpha = 0;
			addChild(buyCar);
			buyCar.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBuyCar);
			buyCar.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutBuyCar);
			buyCar.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownBuyCar);
			
			// Если цена 0 то ставить кнопку "выбрать" иначе ставить "купить"			
			//trace('price = ' + price);
			if (price < 1) 
			{
				selectCar.mouseEnabled = true;
				selectCar.alpha = 1;
				carText.text = "";
				
				buyCar.mouseEnabled = false;
				buyCar.alpha = 0;
			}
			else 
			{
				buyCar.mouseEnabled = true;
				buyCar.alpha = 1;
				
				selectCar.mouseEnabled = false;
				selectCar.alpha = 0;
			}

			
			function onMouseOverBuyCar(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.BUTTON;
			}
			function onMouseOutBuyCar(event:MouseEvent):void
			{
				Mouse.cursor = MouseCursor.AUTO;
			}
			
			// Купить автомобиль
			function onMouseDownBuyCar(event:MouseEvent):void 
			{

				if ( (price > 0) && (buyCar.alpha == 1) ) {
					//var shop:Shop = new Shop();
					
					trace('Купить автомобиль: ' + type);
					Common.server.addEventListener(AppGavannaEvent.COMPLETE, gavannaCompleteHandler);
					Common.server.Please("buyCar",[type] );//buyACar(type);
				} else {
					trace('Выбрать автомобиль: ' + type);
					Common.carCur = type;
					Common.server.Please("SetSetting",[Common.envOn, Common.sfxOn, Common.carCur]);
					
					room.setCurrentCar(); // Обновить авто в магазине
				}
				
				for (var i:Number = 0; i < 9; i++) { 
					for (var j:Number = 0; j < 5; j++) {
						if (room.cars[ i ][ j ]) {
							if (Common.buyCars[ room.cars[ i ][ j ].type - 1 ] == 1)
							{
								room.cars[ i ][ j ].setSelect();
							}
						}
					}
				}
				
				//Common.server.addEventListener(AppGavannaEvent.COMPLETE, gavannaCompleteHandler);
				//Common.server.Please("SetCar", type);
			}
			
			function gavannaCompleteHandler(e:AppGavannaEvent):void {
				Common.server.removeEventListener(AppGavannaEvent.COMPLETE, gavannaCompleteHandler);
				if (Common.buyCars[type-1] == 1){
					setSelect();
				}
			}
		}
		
		// Уствновить кнопку выбрать и скрыть купить
		public function setSelect():void {
			selectCar.mouseEnabled = true;
			selectCar.alpha = 1;
			carText.text = "";
			
			selectOffCar.alpha = 0;
			
			buyCar.mouseEnabled = false;
			buyCar.alpha = 0;
			
			if (Common.carCur == type) {
				setSelectOff();
			}
		}
		
		// Уствновить кнопку выбрать затухшей
		private function setSelectOff():void {
			selectCar.mouseEnabled = false;
			selectCar.alpha = 0;
			carText.text = "";
			
			buyCar.mouseEnabled = false;
			buyCar.alpha = 0;
			
			selectOffCar.alpha = 1;
		}
	}

}