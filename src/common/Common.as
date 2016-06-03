package common
{
	/**
	 * ...
	 * @author baton; Gospodin.Sorokin
	 */
	
	import common.gavanna.AppGavanna;
	import common.net.WallPost;
	import common.vk.APIConnection;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import common.spr.Spr;
	import common.room.Room;
	import common.room.RoomHub;
	import common.room.ControllerRoom;
	import common.sound.Sound;
	import common.lock.Lock;
	import common.car.Car;
	import common.p2p.P2PCommon;
	import common.gavanna.IronScreen;
	import flash.events.Event;
	import common.console.Console;
	public class Common extends Sprite
	{
		public function Common()
		{
			//trace('Common');
		}
		
		public static var idd:String = "12345";
		
		// controllerRoom
		private static var controllerRoom:ControllerRoom = new ControllerRoom;

		// Список купленных авто
		public static var buyCars:Array = [1];
		
		// Список машин
		public static var cars:Array = [1];
		
		// Текущая машина
		public static var carCur:int = 1;
		
		// Включен ENV
		public static var envOn:int;// = 1;
		
		// Включены SFX
		public static var sfxOn:int;// = 1;
		
		public static function createRoom(room:Room, name:String):void
		{
			//trace('Common createRoom');
			controllerRoom.createRoom(room, name);
		}
		
		public static function switchRoom(room:String):void
		{
			//trace('Common switchRoom');
			controllerRoom.switchRoom(room);
		}
		
		public static function get currentRoom():String
		{
			//trace('Common currentRoom' );
			return controllerRoom.currentRoom;
		}

		public static function get previousRoom():String
		{
			//trace('Common previousRoom');
			return controllerRoom.previousRoom;
		}

		public static function get roomField():RoomHub
		{
			//trace('Common roomField' );
			return controllerRoom.roomField;
		}
		
		// Spr
		public static function createSpr(img:Bitmap):Sprite
		{
			//trace('Common createSpr' );
			
			var spr:Spr = new Spr(img);
			return spr;
		}
		
		// Sound
		private static var sound:Sound = new Sound;

		public static function soundPlay(snd:String):void
		{
			//trace('Common soundPlay' );
			sound.play(snd);
		}
		
		public static function soundStop(snd:String):void
		{
			//trace('Common soundPlay' );
			sound.stop(snd);
		}
		
		public static function soundStopAll():void
		{
			//trace('Common soundPlay' );
			sound.stopAll();
		}
		
		public static function soundOnEnv():void
		{
			envOn = 1;
			server.Please("SetSetting",[envOn, sfxOn, carCur] );
		}

		public static function soundOffEnv():void
		{
			envOn = 0;
			sound.stopEnvs();
			server.Please("SetSetting",[envOn, sfxOn, carCur] );
		}
		
		public static function soundOnSfx():void
		{
			sfxOn = 1;
			var temp:Array = [envOn, sfxOn, carCur];
			server.Please("SetSetting",[envOn, sfxOn, carCur] );
		}
		
		public static function soundOffSfx():void
		{
			sfxOn = 0;
			sound.stopSfxs();
			server.Please("SetSetting",[envOn, sfxOn, carCur] );
		}
		
		// Lock
		private static var lock:Lock = new Lock;

		public static function lockApp(value:Number):void
		{
			//trace('Common Lock' );
			lock.lockApp(value);
		}
		
		// Скринчик
		public static var screenProcessing:Boolean = true;
		
		// Для работы в вконтакте
		public static var vkonte:APIConnection;
		
		public static var falshVars:Object;
		
		public static var server:AppGavanna;
		
		public static function wallPost (params:Array):void {
			params[3] = "photo343790711_410848800";
			vkonte.api('wall.post', { message: 'Я занял ' + params[0] +'-е место, со скоростью '+params[1] +' и допустил '+ params[2] +' ошибок. http://vk.com/app5351580', attachment: params[3] } );
		}
		public static function callFrend ():void{
			vkonte.callMethod("showInviteBox");
		}
		public static var console:Console ;
		public static function t(s:String):void {
			console.tr(s);
		}
		public static var wallpost:WallPost ;
		public static function wp(s:String, a:Array):void {
			wallpost.post(s,a);
		}
		/* Получить автомобиль. Если параметр задан вернет указанный авто. Если параметр отстутствует - вернет рендомный авто */
		public static function getCar(number:Number = 0):Car
		{
			//trace('Common get car' );
			return new Car(number);
		}
		
		
	}
}