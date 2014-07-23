package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import MainEngine;
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Preloader extends MovieClip 
{	
	public function Preloader()
	{
		
	}
	
	public function init():void
	{
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	public function onEnterFrame(e:Event):void
	{
		if (loaderInfo.bytesLoaded >= loaderInfo.bytesTotal)
		{
			// If all bytes are loaded, start the game.
			startup();
		}
		else
		{
			// Update your screen to display whatever you'd like.
			trace("Loading...");
		}
	}

	private function startup():void
	{
		stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		var mainClass:Class = MainEngine as Class;
		parent.addChild(new mainClass as DisplayObject);
		parent.removeChild(this);
	}
}

}