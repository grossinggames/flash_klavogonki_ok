
package common.vk 
{
	//import flash.display.Stage;
	import flash.display.*
	import flash.events.*;
	import common.vk.*;

	/**
	 * ...
	 * @author Gospodin.Sorokin
	 */
	public class Vkonte extends Sprite
	{
		private var flashVars: Object;
		private var VK: APIConnection;
		
		public function Vkonte()
		{
			if (stage) { init() 
			} else { addEventListener(Event.ADDED_TO_STAGE, init) };
		}
		
		private function init(e: Event = null): void {
			flashVars = stage.loaderInfo.parameters as Object;
			//flashVars['api_id'] = 4711425;
			//flashVars['viewer_id'] = 13508828;
			//flashVars['sid'] = "d4ef99ebf711049de67d9c5563e904cef96356e4ce9a5f609e7fb2e06f89148b90bc1c7efcbce8b7b42c5";
			//flashVars['secret'] = "8aa15b9580";
			VK = new APIConnection(flashVars);
			VK.api('getProfiles', { uids: flashVars['viewer_id'] });
		}
		
		public function wallPost(params:Array):void
		{
			VK.api('wall.post', { message: 'Я занял ' + params[0] +'-е место, со скоростью '+params[1] +' и допустил '+ params[2] +' ошибок. http://vk.com/app5351580', attachment: "http://cs627625.vk.me/v627625828/4334/bqyR35kYvHI.jpg" } );
		}
		public function wallPost1():void
		{
			VK.api('wall.post', { message: 'Я занял 100 ошибок. http://vk.com/app5351580', attachment: "http://cs627625.vk.me/v627625828/4334/bqyR35kYvHI.jpg" } );
		}
		public function callFrend():void
		{
			VK.callMethod("showInviteBox");
		}
	}
}