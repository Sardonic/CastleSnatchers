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
		private var targeter:RefugeeTargeter
		public var spawnDog:Function;
		
		public function DogSpawner(targeter:RefugeeTargeter, x:Number, y:Number) 
		{
			super(x, y);
			
			this.targeter = targeter;
			spawnDog = null;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.C))
			{
				var escaper:Escaper = targeter.shiftRefugee();
				
				if (escaper)
				{
					spawnDog(new Dog(escaper, x, y));
				}
			}
		}
	}

}