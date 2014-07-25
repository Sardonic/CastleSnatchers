package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class RefugeeSpawner extends Entity
	{
		private var msUntilSpawn:int;
		public var addRenegade:Function;
		private var eventDispatcher:EventDispatcher;
		
		public function RefugeeSpawner(renegadeCallback:Function, x:Number, y:Number) 
		{
			super(x, y);
			msUntilSpawn = FP.rand(2000) + 1000;
			addRenegade = renegadeCallback;
		}
		
		override public function update():void 
		{
			super.update();
			
			msUntilSpawn -= (FP.elapsed * 1000);
			
			if (msUntilSpawn <= 0)
			{
				msUntilSpawn = FP.rand(2000) + 1000;
				addRenegade(new Escaper(x, y));
			}
		}
	}

}