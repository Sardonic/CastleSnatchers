package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(1024, 576, 60, false);
		}
		
		override public function init():void 
		{
			FP.world = new Game();
		}
		
	}
	
}