package
{
	/**
	 * ...
	 * @author baton; Gospodin.Sorokin
	 */
	import common.TestApp;
	import common.gavanna.Gavanas;
	import common.gavanna.Shop;
	import common.vk.Vkonte;
	import flash.display.Sprite;
	import common.Common;
	import common.gavanna.IronScreen;
	import game.rooms.*;
	import flash.events.*;
	
	import common.gavanna.AppGavanna;
	import common.events.AppGavannaEvent;
	import common.console.SWFProfiler;
	
	import common.vk.*;
	import flash.events.*;
	import common.net.WallPost;
	import common.console.Console;
	
	public class App extends Sprite
	{
		private static var ironScreen:IronScreen;
		
		private static var gavanas:Gavanas;
	
		private var appGavanna:AppGavanna;
		private var vkonte:Vkonte;
		private var console:Console;
		private var wallpost:WallPost;
		//private var flashVars: Object;
		//private var VK: APIConnection;
		
		public function App() 
		{
			if (stage) { init() 
			} else { addEventListener(Event.ADDED_TO_STAGE, init) };
			
		}
		private function init(e: Event = null): void {
			//SWFProfiler.init(stage, this);
			
			Common.falshVars = stage.loaderInfo.parameters as Object;
			//if (!Common.falshVars.api_id) {
			//	Common.falshVars['api_id'] = 4972156;
			//	Common.falshVars['viewer_id'] = 13508828;
			//	Common.falshVars['sid'] = "104c2269f185c5316fb34a92be9b2a5606cbbec8ddd15e4f2f058f2a91b28e72a36754b50e04ac2911ce6";
			//	Common.falshVars['secret'] = "88603dc76e";
			//}
			if (Common.falshVars.api_id) {
				Common.idd = (Common.falshVars['viewer_id']);
				Common.vkonte = new APIConnection(Common.falshVars);
				Common.vkonte.api('getProfiles', { uids: Common.falshVars['viewer_id'] }, fetchUserInfo, onApiRequestFail );
			}
				function onApiRequestFail(data: Object): void {
					trace("Error: "+data.error_msg);
				}
				function fetchUserInfo(data: Object): void {
					trace("-- API request result:");
				}
				
			addChild(Common.roomField);
			
			ironScreen = new IronScreen(this);
			ironScreen.x = 400;
			ironScreen.y = 425;
			addChild(ironScreen);
			
			gavanas = new Gavanas();
			addChild(gavanas);
			appGavanna = new AppGavanna(gavanas);
            appGavanna.addEventListener(AppGavannaEvent.COMPLETE, gavannaCompleteHandler);
			appGavanna.Please("Start");
			Common.server = appGavanna;
			
		}
		private function gavannaCompleteHandler(e:AppGavannaEvent):void {
			appGavanna.removeEventListener(AppGavannaEvent.COMPLETE, gavannaCompleteHandler);
			Common.envOn = e.result[0][0];
		    Common.sfxOn = e.result[0][1];
			Common.carCur = e.result[0][2];
			Common.buyCars = e.result[1];
			
			Common.createRoom(new MainRoom, 'MainRoom');
			Common.createRoom(new GameRoom, 'GameRoom');
			Common.createRoom(new StoreRoom, 'StoreRoom');
			
			Common.switchRoom('MainRoom');
			
			console = new Console();
			//addChild(console);
			Common.console = console;
			wallpost = new WallPost();
			Common.wallpost = wallpost;
			//addChild(new WallPost());
			//addChild(new TestApp());
		}
	}
}