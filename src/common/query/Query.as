package common.query 
{
	/**
	 * ...
	 * @author baton
	 */
	public class Query 
	{
		
		public function Query() 
		{
			
		}

		public function buyCar(car:int):void
		{
			// Создаем запос к серверу на покупку автомобиля с идентификатором car
			trace('Купить машину под номером ' + car);
		}
		
	}

}