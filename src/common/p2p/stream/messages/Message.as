package common.p2p.stream.messages 
{
	/**
	 * ...
	 * @author baton
	 */
	public class Message
	{
		// Если переименовываем переменную type, то изменяем и значение TYPE_VARIABLE_NAME
		public static const TYPE_VARIABLE_NAME:String = "type";
		public var type:String;
		
		public var id:String;
		public var name:String;
		public var sender:String;
		public var number:int;
	}
}