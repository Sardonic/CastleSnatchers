package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.debug.Console;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Main extends Sprite
	{
		private var preloader:Preloader
		
		public function Main():void 
		{
			preloader = new Preloader();
			addChild(preloader);
			preloader.init();
		}
		
	}
	
}