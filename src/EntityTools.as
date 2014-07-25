package  
{
	import flash.events.Event;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class EntityTools 
	{
		
		public function EntityTools() 
		{
			// Don't call this.
		}
		
		public static function setBase(e:Entity, x:Number, y:Number):void
		{
			e.x = x;
			e.y = (y - e.height);
		}
		
		public static function kill(e:EventfulEntity):void
		{
			e.world.remove(e);
			e.active = false;
			e.visible = false;
			e.dispatchEvent(new Event(Escaper.DYING_EVENT));
		}
	}

}