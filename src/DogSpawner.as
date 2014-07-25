package  
{
	import flash.events.Event;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class DogSpawner extends Entity 
	{
		private var targeter:RefugeeTargeter;
		private var numDogsAllowed:int;
		private var numDogsAlive:int;
		public var spawnDog:Function;
		
		public function DogSpawner(targeter:RefugeeTargeter, dogSpawnCallback:Function, x:Number, y:Number) 
		{
			super(x, y);
			
			this.targeter = targeter;
			spawnDog = dogSpawnCallback;
			numDogsAllowed = 1;
			numDogsAlive = 0;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (numDogsAlive < numDogsAllowed && Input.pressed(Key.C))
			{
				var escaper:Escaper = targeter.shiftRefugee();
				
				if (escaper)
				{
					var dog:Dog = new Dog(escaper, x, y);
					spawnDog(dog);
					dog.addEventListener(Dog.RETRIEVED_ESCAPER, onDogFinished);
					numDogsAlive++;
				}
			}
		}
		
		private function onDogFinished(e:Event):void 
		{
			numDogsAlive--;
		}
	}

}