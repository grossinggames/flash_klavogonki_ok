package common.car 
{
	/**
	 * ...
	 * @author baton; Gospodin.Sorokin
	 */
	import flash.display.Sprite;
	import flash.display.*;	
	import common.Common;
	
	public class Car extends Sprite
	{
		public var type:int = 0;
		public var description:String = 'Автомобиль номер ' + type;
		public var price:int = 0;
		
		public function Car(number:Number = 0) 
		{
			var descriptions:Array = [];
			var cars:Array = [];
			var prices:Array = [];

			// Добавили машину 1
			[Embed(source = "../../../lib/images/car1.png")] 
			var car1Class:Class;
			car = Common.createSpr( new car1Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('       ЗАЗ');
			prices.push(0);
			
			// Добавили машину 2
			[Embed(source = "../../../lib/images/car2.png")] 
			var car2Class:Class;
			car = Common.createSpr( new car2Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Caterpillar 247B');
			prices.push(10);

			// Добавили машину 3
			[Embed(source = "../../../lib/images/car3.png")] 
			var car3Class:Class;
			car = Common.createSpr( new car3Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Chevrolet EN-V');
			prices.push(5);
			
			// Добавили машину 4
			[Embed(source = "../../../lib/images/car4.png")] 
			var car4Class:Class;
			car = Common.createSpr( new car4Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Volkswagen \n Beetle');
			prices.push(5);
			
			// Добавили машину 5
			[Embed(source = "../../../lib/images/car5.png")] 
			var car5Class:Class;
			car = Common.createSpr( new car5Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Duesenberg \n Speedster');
			prices.push(15);
			
			// Добавили машину 6
			[Embed(source = "../../../lib/images/car6.png")] 
			var car6Class:Class;
			car = Common.createSpr( new car6Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('   Ferrari 250 \n Testa Rossa');
			prices.push(8);
			
			// Добавили машину 7
			[Embed(source = "../../../lib/images/car7.png")] 
			var car7Class:Class;
			car = Common.createSpr( new car7Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('    Трамвай');
			prices.push(10);
			
			// Добавили машину 8
			[Embed(source = "../../../lib/images/car8.png")] 
			var car8Class:Class;
			car = Common.createSpr( new car8Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('   ВАЗ 2104');
			prices.push(4);
			
			// Добавили машину 9
			[Embed(source = "../../../lib/images/car9.png")] 
			var car9Class:Class;
			car = Common.createSpr( new car9Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('   УАЗ 3151');
			prices.push(6);
			
			// Добавили машину 10
			[Embed(source = "../../../lib/images/car10.png")] 
			var car10Class:Class;
			car = Common.createSpr( new car10Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('  Fiat Strada');
			prices.push(3);
			
			// Добавили машину 11
			[Embed(source = "../../../lib/images/car11.png")] 
			var car11Class:Class;
			car = Common.createSpr( new car11Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Peugeot Boxer');
			prices.push(5);

			// Добавили машину 12
			[Embed(source = "../../../lib/images/car12.png")] 
			var car12Class:Class;
			car = Common.createSpr( new car12Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Hummer H3');
			prices.push(10);

			// Добавили машину 13
			[Embed(source = "../../../lib/images/car13.png")] 
			var car13Class:Class;
			car = Common.createSpr( new car13Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('LM Rally Fighter');
			prices.push(25);
			
			// Добавили машину 14
			[Embed(source = "../../../lib/images/car14.png")] 
			var car14Class:Class;
			car = Common.createSpr( new car14Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Daewoo Matiz');
			prices.push(1);
			
			// Добавили машину 15
			[Embed(source = "../../../lib/images/car15.png")] 
			var car15Class:Class;
			car = Common.createSpr( new car15Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Ford Focus Mk2');
			prices.push(4);
			
			// Добавили машину 16
			[Embed(source = "../../../lib/images/car16.png")] 
			var carClass:Class;
			car = Common.createSpr( new carClass() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Renault Megane');
			prices.push(8);
			
			// Добавили машину 17
			[Embed(source = "../../../lib/images/car17.png")] 
			var car17Class:Class;
			car = Common.createSpr( new car17Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Toyota Land Cruiser');
			prices.push(9);
			
			// Добавили машину 18
			[Embed(source = "../../../lib/images/car18.png")] 
			var car18Class:Class;
			car = Common.createSpr( new car18Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Smart Fortwo');
			prices.push(2);
			
			// Добавили машину 19
			[Embed(source = "../../../lib/images/car19.png")] 
			var car19Class:Class;
			car = Common.createSpr( new car19Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Nissan Round Box');
			prices.push(3);
			
			// Добавили машину 20
			[Embed(source = "../../../lib/images/car20.png")] 
			var car20Class:Class;
			car = Common.createSpr( new car20Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Chevrolet Orlando');
			prices.push(7);

			// Добавили машину 21
			[Embed(source = "../../../lib/images/car21.png")] 
			var car21Class:Class;
			car = Common.createSpr( new car21Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Volkswagen \n Passat B3');
			prices.push(3);

			// Добавили машину 22
			[Embed(source = "../../../lib/images/car22.png")] 
			var car22Class:Class;
			car = Common.createSpr( new car22Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Mitsubishi Lancer X');
			prices.push(6);

			// Добавили машину 23
			[Embed(source = "../../../lib/images/car23.png")] 
			var car23Class:Class;
			car = Common.createSpr( new car23Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('    BMW X6');
			prices.push(10);
			
			// Добавили машину 24
			[Embed(source = "../../../lib/images/car24.png")] 
			var car24Class:Class;
			car = Common.createSpr( new car24Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Subaru Tourer');
			prices.push(10);
			
			// Добавили машину 25
			[Embed(source = "../../../lib/images/car25.png")] 
			var car25Class:Class;
			car = Common.createSpr( new car25Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Citroen Hypnos');
			prices.push(13);
			
			// Добавили машину 26
			[Embed(source = "../../../lib/images/car26.png")] 
			var car26Class:Class;
			car = Common.createSpr( new car26Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Bugatti Galibier');
			prices.push(14);
			
			// Добавили машину 27
			[Embed(source = "../../../lib/images/car27.png")] 
			var car27Class:Class;
			car = Common.createSpr( new car27Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('    Audi TT');
			prices.push(7);
			
			// Добавили машину 28
			[Embed(source = "../../../lib/images/car28.png")] 
			var car28Class:Class;
			car = Common.createSpr( new car28Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Lamborghini \n Murcielago');
			prices.push(15);
			
			// Добавили машину 29
			[Embed(source = "../../../lib/images/car29.png")] 
			var car29Class:Class;
			car = Common.createSpr( new car29Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Dodge Viper');
			prices.push(17);
			
			// Добавили машину 30
			[Embed(source = "../../../lib/images/car30.png")] 
			var car30Class:Class;
			car = Common.createSpr( new car30Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('  Болид F1');
			prices.push(30);

			// Добавили машину 31
			[Embed(source = "../../../lib/images/car31.png")] 
			var car31Class:Class;
			car = Common.createSpr( new car31Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Bugatti Veyron');
			prices.push(35);

			// Добавили машину 32
			[Embed(source = "../../../lib/images/car32.png")] 
			var car32Class:Class;
			car = Common.createSpr( new car32Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Ferrari Zobin');
			prices.push(40);

			// Добавили машину 33
			[Embed(source = "../../../lib/images/car33.png")] 
			var car33Class:Class;
			car = Common.createSpr( new car33Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Ferrari FX Concept');
			prices.push(50);
			
			// Добавили машину 34
			[Embed(source = "../../../lib/images/car34.png")] 
			var car34Class:Class;
			car = Common.createSpr( new car34Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('  Бэтмобиль');
			prices.push(100);
			
			// Добавили машину 35
			[Embed(source = "../../../lib/images/car35.png")] 
			var car35Class:Class;
			car = Common.createSpr( new car35Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Danny Chang \n Concept');
			prices.push(60);
			
			// Добавили машину 36
			[Embed(source = "../../../lib/images/car36.png")] 
			var car36Class:Class;
			car = Common.createSpr( new car36Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('Aeroglisser');
			prices.push(80);
			
			// Добавили машину 37
			[Embed(source = "../../../lib/images/car37.png")] 
			var car37Class:Class;
			car = Common.createSpr( new car37Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('       SS-1');
			prices.push(100);
			
			// Добавили машину 38
			[Embed(source = "../../../lib/images/car38.png")] 
			var car38Class:Class;
			car = Common.createSpr( new car38Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('       НЛО');
			prices.push(150);
			
			// Добавили машину 39
			[Embed(source = "../../../lib/images/car39.png")] 
			var car39Class:Class;
			car = Common.createSpr( new car39Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('   Инсекатор');
			prices.push(250);
			
			// Добавили машину 40
			[Embed(source = "../../../lib/images/car40.png")] 
			var car40Class:Class;
			car = Common.createSpr( new car40Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push('     SS-X');
			prices.push(200);

			// Добавили машину 41
			[Embed(source = "../../../lib/images/car41.png")] 
			var car41Class:Class;
			var car:Sprite = Common.createSpr( new car41Class() );
			car.alpha = 0;
			addChild(car);
			cars.push(car);
			descriptions.push(' Беларус 922');
			prices.push(5);

			var showCar:int = randomInt(1, 41);
			type = showCar;
			
			if (number) {
				showCar = number;
				type = showCar;
			} 
			else 
			{
				if (prices[type - 1] > 20)
				{
					showCar = randomInt(1, 41);
					type = showCar;
				}
				if (prices[type - 1] > 20)
				{
					showCar = randomInt(1, 41);
					type = showCar;
				}
			}
			
			//trace('Prices  ' + prices[type - 1]);
			
			cars[type - 1].alpha = 1
			description = descriptions[type - 1];
			price = prices[type - 1];
		}
		
		// Рендомное число типа int
		private function randomInt(min:Number, max:Number):Number {
			var rand:Number = min + Math.random() * (max + 1 - min);
			rand = Math.floor(rand);
			return rand;
		}
		
	}
}