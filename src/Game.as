package
{
	import flash.events.Event;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Game extends World
	{
		private var health:int;
		private var castle:Castle;
		private var renegades:Array;
		private var healthText:Text;
		private var spawner:RefugeeSpawner;
		private var harpoon:Harpoon;
		private var healthUI:Entity;
		private var targeter:RefugeeTargeter;
		
		public function Game()
		{
			targeter = new RefugeeTargeter();
			
			placeCastle();
			addSpawner();
			setHealthToDefault();
			addHealthUI();
			addHarpoon();
		}
		
		override public function render():void 
		{
			healthText.text = health.toString();
			healthText.x = FP.width - healthText.textWidth;
			
			super.render();
		}
		
		public function changeHealth(dec:int):void
		{
			health -= dec;
		}
		
		public function addRenegade(x:Number, y:Number):Escaper
		{
			var newGuy:Escaper = new Escaper(x, y);
			add(newGuy);
			newGuy.addEventListener(Escaper.EXIT_SCREEN_EVENT, onPeasantExit);
			newGuy.addEventListener(Escaper.EXIT_SCREEN_EVENT, targeter.onRefugeeExitScreen);
			newGuy.addEventListener(Escaper.EXIT_HARPOON_RANGE_EVENT, targeter.onRefugeeExitHarpoonRange);
			return newGuy;
		}
		
		private function onPeasantExit(e:Event):void 
		{
			changeHealth(5);
		}
		
		private function placeCastle():void 
		{
			castle = new Castle();
			castle.setBase(0, FP.height - 100);
			castle.layer = Layers.CASTLE;
			add(castle);
		}
		
		private function addSpawner():void 
		{
			spawner = new RefugeeSpawner(castle.right - Escaper.getWidth(), castle.bottom - Escaper.getHeight());
			spawner.addRenegade = addRenegade;
			add(spawner); // Spawner has no image, but this forces it's update method to be called every frame.
		}
		
		private function addHealthUI():void 
		{
			healthText = new Text(health.toString());
			healthText.x = FP.width - healthText.textWidth;
			healthText.y = 0;
			healthUI = addGraphic(healthText);
		}
		
		private function setHealthToDefault():void 
		{
			health = 100;
		}
		
		private function addHarpoon():void 
		{
			harpoon = new Harpoon();
			harpoon.x = castle.right - harpoon.width - 21; // account for flag's width
			harpoon.y = castle.bottom - harpoon.height;
			harpoon.layer = Layers.BEHIND_CASTLE;
			add(harpoon);
			
			harpoon.setStartX(harpoon.x);
			harpoon.startY = harpoon.y;
		}
	}

}