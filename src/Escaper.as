package  
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.Mask;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Escaper extends Entity 
	{
		[Embed(source="../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Refugee_Running_1_strip2.png")]
		private const RUNNING:Class;
		
		public var speed:Number;
		public var runAnim:Spritemap;
		public var running:Boolean;
		public var skewered:Boolean;
		public static var changeHealth:Function;
		
		public function Escaper(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			var runAnim:Spritemap = new Spritemap(RUNNING, 64, 101);
			
			runAnim.add("run", [0, 1], 12, true);
			
			speed = 100;
			running = true;
			skewered = false;
			
			this.type = "Renegade";
			
			this.setHitbox(runAnim.width, runAnim.height);
			
			super(x, y, runAnim, mask);
			runAnim.play("run");
		}
		
		public function setBase(x:Number, y:Number):void
		{
			this.x = x;
			this.y = (y - this.height); // subtract height
		}
		
		override public function update():void 
		{
			super.update();
			
			if (running)
			{
				x += speed * FP.elapsed;
			
				if (x >= FP.width)
				{
					changeHealth(5);
					running = false;
				}
			}
		}
	}

}