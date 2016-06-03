package common.p2p
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import common.p2p.stream.messages.TransitionWalkMessage;
	import common.p2p.stream.messages.Message;
	import common.p2p.stream.messages.PositionMessage;
	import common.p2p.stream.P2P;
	import common.p2p.stream.P2PEvent;
	import common.Common;
	/**
	 * ...
	 * @author baton
	 */
	
	public class P2PCommon extends Sprite 
	{
		private var loader:URLLoader = new URLLoader;
		private var p2p:P2P          = new P2P;
		public  var canMove:Boolean  = false;
		public  var users:Object  = { };
		private var timer:Timer;
		
		public function P2PCommon():void 
		{
			//Добавляем логгирование
			var log:Log = new Log(800, 600);
			this.addChild(log);
		}
		
		//***************************** Таймер *****************************
		//На каждый тик таймера
		private function onTimer(event:TimerEvent):void 
		{
			Log.print("onTimer = " + event.target.currentCount);
		}
		
		//На окончание таймера
		private function onTimerComplete(event:TimerEvent):void 
		{
			Log.print("onTimerComplete");
			cancelGame();
		}
		
		//***************************** Имя команты *****************************
		//Получить имя новой комнаты от сервера
		public function connect():void 
		{
			Log.print("request connect");
			
			timer = new Timer(1000, 20);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
			timer.start();
			
			var randomNumber:Number = Math.random();
			var request:URLRequest=new URLRequest('https://p2p-server-grossinggames-1.c9users.io/get_room?param1=' + randomNumber);
			loader.addEventListener(Event.COMPLETE, onGetRoom);
			loader.load(request);
		}
		
		//После получения имени комнаты от сервера
		private function onGetRoom(event:Event):void 
		{
			Log.print("GetRoom");
			var groupName:String = String(loader.data);
			
			cancelGame();
			
			p2p.connect(groupName);
			p2p.addEventListener(P2PEvent.CONNECT_SUCCESS, p2pConnectSuccessHandler);
			p2p.addEventListener(P2PEvent.RECEIVE_MESSAGE, p2pReceiveMessageHandler);
			p2p.addEventListener(P2PEvent.ADD_NEIGHBOR, p2pAddNeighborHandler);
			p2p.addEventListener(P2PEvent.REMOVE_NEIGHBOR, p2pRemoveNeighborHandler);
		}
		
		//Отменить поиск игры
		public function cancelGame():void 
		{
			Log.print("LOADER CLOSE");

			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.stop();
			
			loader.removeEventListener(Event.COMPLETE, onGetRoom);
			loader.close();
		}
		
		//***************************** P2P Комнта *****************************
		//На корректный вход в p2p комнату
		private function p2pConnectSuccessHandler(event:P2PEvent):void
		{
			p2p.removeEventListener(P2PEvent.CONNECT_SUCCESS, p2pConnectSuccessHandler);
			
			var user:User = users[event.name];
			if (!user)
			{
				addUser(event.name);
			}
		}
		
		//Выйти из p2p комнаты
		public function disconnect():void
		{
			canMove = false;
			p2p.disconnect();
			removeUsers();
			p2p.removeEventListener(P2PEvent.RECEIVE_MESSAGE, p2pReceiveMessageHandler);
			Common.switchRoom("MainRoom");
		}

		//На выход соперника
		private function p2pRemoveNeighborHandler(event:P2PEvent):void
		{
			p2p.removeEventListener(P2PEvent.REMOVE_NEIGHBOR, p2pRemoveNeighborHandler);
			disconnect();
		}
		
		//***************************** P2P Обработка Сообщений *****************************
		//Обработка всех входящих сообщений
		private function p2pReceiveMessageHandler(event:P2PEvent):void
		{
			var message:Message = event.message;
			
			switch (message.type)
			{
				//Обработка новых позиций
				case PositionMessage.POSITION_MESSAGE:
					onPositionMessage(PositionMessage(message));
					break;
				//Обработка перехода хода
				case TransitionWalkMessage.TRANSITION_WALK_MESSAGE:
					onTransitionWalkMessage(TransitionWalkMessage(message));
					break;
			}
		}
		
		//Добавить соперника в список
		private function p2pAddNeighborHandler(event:P2PEvent):void
		{
			p2p.removeEventListener(P2PEvent.ADD_NEIGHBOR, p2pAddNeighborHandler);
			var user:User = users[event.name];
			if (!user)
			{
				addUser(event.name);
			}
			canMove = true;
			Common.switchRoom("GameRoom");
		}
		
		//Обработка новых позиций
		private function onPositionMessage(message:PositionMessage):void
		{
			Log.print('onPositionMessage message.name = ' + message.name);
			
			var user:User = users[message.name];
			if (user)
			{
				user.moveTo(message.x, message.y);
			}
		}
		
		//Обработка перехода хода
		private function onTransitionWalkMessage(message:TransitionWalkMessage):void
		{
			Log.print('TransitionWalkMessage  message.name = ' + message.name);
			canMove = message.allow;
			Log.print( String(message.allow) );
		}
		
		//***************************** P2P Отправка сообщений *****************************
		//Отправить сообщение с новыми позициями
		public function sendPositionMessage(currentX:int, currentY:int):void
		{
			var message:PositionMessage = new PositionMessage();
			message.x = currentX;
			message.y = currentY;
			p2p.sendMessage(message);
		}
		
		//Передать ход сопернику
		public function sendAllowWalkMessage():void
		{
			var message:TransitionWalkMessage = new TransitionWalkMessage();
			message.allow = true;
			p2p.sendMessage(message);
		}
		
		//***************************** P2P Визуальное представление *****************************
		//Создать игрока
		private function addUser(userId:String):void
		{
			var user:User = new User();
			users[userId] = user;
			Log.print('addUser username = ' + userId);
		}
		
		//Удаить отображение соперника
		private function removeUsers():void
		{
			//Common.roomField.removeChild(users['me']);
			//Common.roomField.removeChild(users['neighbor']);
		}
		
	}
}