package  
{
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class RefugeeFactory extends Entity
	{
		public var msUntilSpawn:int;
		public var addRenegade:Function;
		
		public function RefugeeFactory(x:Number, y:Number) 
		{
			super(x, y);
			msUntilSpawn = FP.rand(2000) + 1000;
			addRenegade = null;
		}
		
		public function makeRefugee():Escaper
		{
			return new Escaper(x, y);
		}
		
		override public function update():void 
		{
			super.update();
			
			msUntilSpawn -= (FP.elapsed * 1000);
			
			if (msUntilSpawn <= 0)
			{
				msUntilSpawn = FP.rand(2000) + 1000;
				addRenegade(x, y);
			}
		}
	}

}