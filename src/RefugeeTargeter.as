package  
{
	import flash.events.Event;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class RefugeeTargeter 
	{
		// Contains the refugees, ordered from "escaped long time ago" to "escaped recently"
		private var refugees:Array;
		private var arrow:TargetingArrow;
		
		public function RefugeeTargeter() 
		{
			refugees = new Array();
			arrow = new TargetingArrow();
		}
		
		public function popRefugee():Escaper
		{
			return refugees.pop() as Escaper;
		}
		
		public function shiftRefugee():Escaper
		{
			return refugees.shift() as Escaper;
		}
		
		public function onRefugeeExitHarpoonRange(e:Event):void
		{
			var newGuy:Escaper = e.currentTarget as Escaper;
			refugees.push(newGuy);
			if (arrow.getBoundEntity() == null)
			{
				arrow.bindToEntity(newGuy);
				newGuy.world.add(arrow);
			}
		}
		
		public function onRefugeeDeath(e:Event):void
		{
			removeRefugee(e.currentTarget as Escaper);
		}
		
		public function onRefugeeExitScreen(e:Event):void
		{
			removeRefugee(e.currentTarget as Escaper);
			var ref:Escaper = refugees[0];
			
			if (ref)
			{
				arrow.bindToEntity(ref);
			}
		}
		
		public function onRefugeeAttacked(e:Event):void
		{
			removeRefugee(e.currentTarget as Escaper);
		}
		
		public function removeRefugee(refugee:Escaper):void
		{
			if (refugees.indexOf(refugee) > -1)
			{
				if (arrow.getBoundEntity() == refugee)
				{
					arrow.unbind();
				}
				refugees.splice(refugees.indexOf(refugee), 1);
			}
		}
	}

}