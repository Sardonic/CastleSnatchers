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
		
		public function RefugeeTargeter(game:Game) 
		{
			game.addEventListener(Game.ADDED_ESCAPER, onRefugeeAdded);
			refugees = new Array();
			arrow = new TargetingArrow();
		}
		
		private function onRefugeeAdded(e:Event):void 
		{
			var game:Game = e.currentTarget as Game;
			
			var newGuy:Escaper = game.getNewestEscaper();
			newGuy.addEventListener(Escaper.EXIT_SCREEN_EVENT, onRefugeeExitScreen);
			newGuy.addEventListener(Escaper.EXIT_HARPOON_RANGE_EVENT, onRefugeeExitHarpoonRange);
		}
		
		public function shiftRefugee():Escaper
		{
			if (refugees.length > 0)
			{
				var e:Escaper = refugees.shift();
				var next:Escaper = refugees[0];
				
				if (next)
				{
					arrow.bindToEntity(next);
				}
				else
				{
					arrow.world.remove(arrow);
					arrow.unbind();
				}
				
				return e as Escaper;
			}
			else
				return null;
		}
		
		public function peek():Escaper
		{
			if (refugees.length > 0)
			{
				return refugees[0];
			}
			
			return null;
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
		
		public function onRefugeeExitScreen(e:Event):void
		{
			shiftRefugee();
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
		
		public function getCurrentTarget():Entity
		{
			return arrow.getBoundEntity();
		}
	}

}