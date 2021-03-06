package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
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
	public class Game extends World implements IEventDispatcher
	{
		private var health:int;
		private var castle:Castle;
		private var renegades:Array;
		private var healthText:Text;
		private var spawner:RefugeeSpawner;
		private var harpoon:Harpoon;
		private var healthUI:Entity;
		private var targeter:RefugeeTargeter;
		private var eventDispatcher:EventDispatcher;
		private var newestEscaper:Escaper;
		private var dogSpawner:DogSpawner;
		
		public static const ADDED_ESCAPER:String = "Added escaper";
		public static const ADDED_ENTITY:String = "Added entity";
		
		public function Game()
		{
			eventDispatcher = new EventDispatcher(this);
			targeter = new RefugeeTargeter(this);
			
			placeCastle();
			addSpawner();
			addDogSpawner();
			setHealthToDefault();
			addHealthUI();
			addHarpoon();
		}
		
		private function addDogSpawner():void 
		{
			dogSpawner = new DogSpawner(targeter, spawnDog, -Dog.getWidth(), castle.bottom - Dog.getHeight());
			add(dogSpawner);
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
		
		public function addRenegade(e:Escaper):Escaper
		{
			add(e);
			newestEscaper = e;
			eventDispatcher.dispatchEvent(new Event(ADDED_ESCAPER));
			
			// Maybe this one deserves its own class?
			e.addEventListener(Escaper.EXIT_SCREEN_EVENT, onPeasantExit);
			
			return e;
		}
		
		public function getNewestEscaper():Escaper
		{
			return newestEscaper;
		}
		
		public function spawnDog(dog:Dog):Dog
		{
			add(dog);
			//eventDispatcher.dispatchEvent(Game.ADDED_DOG);
			dog.addEventListener(Dog.RETRIEVED_ESCAPER, onDogSuccess);
			return dog;
		}
		
		private function onDogSuccess(e:Event):void 
		{
			health += 5;
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
		
		override public function add(e:Entity):Entity 
		{
			var entity:Entity = super.add(e);
			dispatchEvent(new Event(ADDED_ENTITY));
			return entity;
		}
		
		private function onPeasantExit(e:Event):void 
		{
			changeHealth(5);
		}
		
		private function placeCastle():void 
		{
			castle = new Castle();
			EntityTools.setBase(castle, 0, FP.height - 100);
			castle.layer = Layers.CASTLE;
			add(castle);
		}
		
		private function addSpawner():void 
		{
			spawner = new RefugeeSpawner(addRenegade, castle.right - Escaper.getWidth(), castle.bottom - Escaper.getHeight());
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