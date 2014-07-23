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
		private var game:Game;
		
		public function RefugeeSpawner(game:Game, x:Number, y:Number) 
		{
			super(x, y);
			this.game = game;
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
				game.addRenegade(new Escaper(x, y));
			}
		}
	}

}