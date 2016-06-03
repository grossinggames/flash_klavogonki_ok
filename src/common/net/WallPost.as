package common.net 
{
	import common.Common;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.*;
	/**
	 * ...
	 * @author Gospodin.Sorokin
	 */
	public class WallPost extends Sprite
	{
		
		private var url					:String = "http://cs626529.vk.me/v626529828/a127/lZR-Bm9B194.jpg";
		private var fl_Loader			:Loader;
		private var byteArray			:ByteArray = new ByteArray();
		private var mll					:MultipartURLLoader;
		private var type				:String;
		private var masse				:String;
		private var arr					:Array;
		
		public function WallPost() 
		{
			//onSaveWallPhoto1();
		}
		public function post(type:String, arr:Array):void {
			this.type = type;
			this.arr = arr;
			drawImage();
		}
		private function fl_ClickToLoadUnloadSWF():void
		{
			fl_Loader = new Loader();
			fl_Loader.load(new URLRequest(url));
			fl_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawImage);
		}
		private function drawImage(event:Event = null):void
		{
			if (type == "EndRace") {
				[Embed(source="../../../lib/images/2.png")]
				var resultClass:Class;
				masse = 'Я занял '+arr[0]+'-е место, со скоростью '+arr[1]+' и допустил '+arr[2]+' ошибок. http://vk.com/app5351580'
			} else if ( type == "Send" ) {
				
			}
			var bitMAP:Bitmap = new resultClass();
			var myBitmap:BitmapData = new BitmapData(bitMAP.width, bitMAP.height, false);
			myBitmap.draw(bitMAP);
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			byteArray = jpgEncoder.encode(myBitmap);
			Common.vkonte.api("photos.getWallUploadServer", { user_id:Common.falshVars['viewer_id'] }, responseFromServer, error);
		}
		private function responseFromServer(data:Object):void
		{
			mll = new MultipartURLLoader();
			mll.addEventListener(Event.COMPLETE, onUploadCompleteThroughAlarm);
			mll.addFile(byteArray, "file.jpg", "file1", 'image/jpg');
			mll.load(data.upload_url);
		}
		private function onUploadCompleteThroughAlarm(e:Event):void
		{
			var answer:String = mll.loader.data;
			var data:Object = JSON.parse(answer);
			Common.vkonte.api('photos.saveWallPhoto', {uid: Common.falshVars['viewer_id'], server:data.server, photo:data.photo, hash:data.hash }, onSaveWallPhoto, error);
		}
		private function onSaveWallPhoto(data:Array):void {
			Common.vkonte.api("wall.post", { message: masse, attachments:data[0].id }, wallpost, error);       
		}
        private function wallpost(data: Object):void {
        }
		private function error(data: Object):void {
		}
	}

}