package common.gavanna 
{
	import flash.display.Sprite;
	import common.gavanna.Gavanas;
	import common.events.AppGavannaEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
	import common.Common;
    /**
	 * ...
	 * @author Gospodin.Sorokin
	 */
    public class AppGavanna extends Sprite
    {
        private var systemTimer:Timer;
		private var _id:String;
		private var _argument:Array;
		private var _resultServer :Array = [""];
		private var _gavanas:Gavanas;
		
        public function AppGavanna(_gavanas:Gavanas)
        {
            this._gavanas = _gavanas;
			
            systemTimer = new Timer(1000);
            systemTimer.addEventListener(TimerEvent.TIMER, tickHandler);
            //systemTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
        }
        
        private function sendColmplete():void
        {
            var event:AppGavannaEvent = new AppGavannaEvent(AppGavannaEvent.COMPLETE);
			
			switch(_id)
			{
				case "Start":
					_resultServer[0] = _gavanas.getUserSetting();
					_resultServer[1] = _gavanas.getUserCar();
					break;
				case "GetSetting":
					_resultServer = _gavanas.getUserSetting();
					break;
				case "GetCar":
					_resultServer = _gavanas.getUserCar();
					break;
				case "SetSetting":
					//setUserSetting(_argument);
					break;
				case "SetCar":
					//setUserCar(_argument[0]);
					break;
				default:
					trace("Out of range");
					break;
			}
            event.result = _resultServer;
            this.dispatchEvent(event);
			systemTimer.stop();
			Common.screenProcessing = false;
        }
        
        private function tickHandler(event:TimerEvent):void
        {
            if (_gavanas.serverProcessing == false) {
				sendColmplete();
			}
        }
        
        private function completeHandler(event:TimerEvent):void
        {
            this.dispatchEvent(new AppGavannaEvent(AppGavannaEvent.COMPLETE));
        }
		
		public function Please(_id:String, ... _argument):void
		{
			Common.screenProcessing = true;
			systemTimer.start();
			
			switch(_id)
			{
				case "Start":
					_gavanas.findUserData();
					break;
				case "SetSetting":
					Common.screenProcessing = false;
					_gavanas.setUserSetting(_argument);
					break;
				case "SetCar":
					Common.screenProcessing = false;
					_gavanas.setUserCar(int[_argument]);
					break;
				case "GetSetting":
					//_resultServer = getUserSetting();
					break;
				case "GetCar":
					//_resultServer = getUserCar();
					break;
				case "buyCar":
					_gavanas.buyACar(Number(_argument));
					//_resultServer = getUserCar();
					break;
				default:
					break;
			}
			
			this._id = _id;
			this._argument = _argument;
		}
    }
}