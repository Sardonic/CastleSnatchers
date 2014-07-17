package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class BloodEmitter extends Entity 
	{
		[Embed(source = "../assets/img/Sick Paint ARt by LEAD DESIGNER/Blood/texture.png")]
		public const IMG:Class;
		
		public var emitter:Emitter;
		
		public function BloodEmitter(x:Number=0, y:Number=0) 
		{
			emitter = new Emitter(IMG);
			emitter.newType("blood");
			//emitter.setMotion("blood", 270, 
			
			super(x, y);
		}
		
	}

}