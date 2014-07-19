package  
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class MainEngine extends Engine
	{
		
		public function MainEngine() 
		{
			super(1024, 576, 60, false);
		}
		
		override public function init():void 
		{
			FP.console.enable();
			FP.world = new Game();
		}
	}

}