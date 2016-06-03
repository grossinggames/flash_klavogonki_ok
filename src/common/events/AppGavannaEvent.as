package common.events 
{
	import flash.events.Event;
    /**
	 * ...
	 * @author Edgar
	 */
    public class AppGavannaEvent extends Event
    {
        public static const ERROR:String = 'appGavannaError';
        public static const COMPLETE:String = 'appGavannaComplete';

        public function AppGavannaEvent(type:String)
        {
            super(type);
        }
        public var result:Array;
        //public var danger:Boolean;
    }
}