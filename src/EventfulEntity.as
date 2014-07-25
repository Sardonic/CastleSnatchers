package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class EventfulEntity extends Entity implements IEventDispatcher 
	{
		private var eventDispatcher:EventDispatcher;
		
		public static const DESTROYED_EVENT:String = "Entity Destroyed";
		
		public function EventfulEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			eventDispatcher = new EventDispatcher(this);
		}
		
		override public function removed():void 
		{
			dispatchEvent(new Event(DESTROYED_EVENT));
			
			super.removed();
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return eventDispatcher.willTrigger(type);
		}
		
	}

}