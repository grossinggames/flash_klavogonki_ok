package common.gavanna 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.net.*;
	import common.vk.*;
	import common.Common;
	import game.rooms.StoreRoom;
	/**
	 * ...
	 * @author ...
	 */
	public class Shop extends Sprite
	{
		private var CarCell:game.rooms.StoreRoom;
		private var flashVars:Object;
		private var VK:APIConnection;
		
		public function Shop() 
		{
			trace("gfdgоло");
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}	
	public function init(e: Event = null): void 
		{
			trace("Голосены");
			flashVars = stage.loaderInfo.parameters as Object;
			VK = new APIConnection(flashVars);
					VK.addEventListener('onOrderSuccess', onSuccess); //если все прошло удачно
					VK.addEventListener('onOrderCancel', onCanc); //если пользователь отменил передачу
					VK.addEventListener('onOrderFail', onError); //если произошла ошибка
					VK.callMethod('showOrderBox', { type:'item', item:13 } );//вызов окна перевода голосов ;type:'item' - окно покупки товара(возможно также окно вызова офферов или окно пополнения голосов),item:'item1'- номер товара
					
		
		 function onSuccess(data: Object):void
					{
						trace("Голоса переведены");
						
					}
//при отмене      
				function onCanc(data: Object):void
					{
						trace("Вы отменили перевод");
					}
//при ошибке
			 function onError(data: Object):void
					{
						trace(data.error_msg);
					}	
				
		}	
			
					
			
		 
		}
		
	}

