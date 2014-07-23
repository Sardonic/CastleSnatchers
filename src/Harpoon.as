package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Harpoon extends Entity
	{
		[Embed(source="../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Wiggly_Harpoon_strip3.png")]
		public const IMG:Class;
		
		public var maxDist:Number;
		public var distTravelled:Number;
		public var speed:Number;
		
		public var holdTime:Number;
		public var holdTimeElapsed:Number;
		
		public var startX:Number;
		public var startY:Number;
		
		public var skeweredRenegades:Array;
		
		private var state:int;
		private const EXTENDING:int = 0;
		private const HOLDING:int = 1;
		private const RETRACTING:int = 2;
		private const INACTIVE:int = 3;
		
		public function Harpoon(x:Number=0, y:Number=0) 
		{
			var img:Spritemap = new Spritemap(IMG, 492, 93);
			img.add("taut", [0], 0, false);
			img.add("wiggly", [0, 1, 2], 12, true);
			img.play("taut");
			super(x, y, img);
			setHitbox(img.width, img.height);
			startX = x;
			startY = y;
			speed = 1500;
			
			maxDist = startX + this.width;
			distTravelled = 0;
			
			holdTime = 1200;
			holdTimeElapsed = 0;
			
			state = INACTIVE;
			
			skeweredRenegades = new Array();
			
			name = "harpoon";
		}
		
		public function setStartX(x:Number):void
		{
			startX = x;
			maxDist = startX + this.width;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.check(Key.SPACE))
			{
				attack();
			}
			
			switch (state)
			{
				case EXTENDING:
					extend();
					break;
				case HOLDING:
					hold();
					break;
				case RETRACTING:
					retract();
					break;
			}
		}
		
		private function extend():void
		{
			if (this.x + speed * FP.elapsed < maxDist)
			{
				this.x += speed * FP.elapsed;
				
				skeweredRenegades = new Array();
				this.collideTypesInto(["Renegade"], x, y, skeweredRenegades)
				for each (var r:Escaper in skeweredRenegades)
				{
					r.skewer();
					r.layer = Layers.BEHIND_CASTLE;
				}
				this.world.getInstance("castle").open();
			}
			else
			{
				this.x = maxDist;
				state = HOLDING;
			}
		}
		
		private function hold():void
		{
			holdTimeElapsed += FP.elapsed * 1000;
			
			if (holdTimeElapsed >= holdTime)
			{
				holdTimeElapsed = 0;
				state = RETRACTING;
			}
		}
		
		private function retract():void
		{
			if (this.x - speed * FP.elapsed > startX)
			{
				this.x -= speed * FP.elapsed;
				for each (var r:Escaper in skeweredRenegades)
				{
					r.x -= speed * FP.elapsed;
				}
			}
			else
			{
				this.x = startX;
				for each (var r2:Escaper in skeweredRenegades)
				{
					r2.die();
				}
				state = INACTIVE;
				this.world.getInstance("castle").close();
			}
		}
		
		public function attack():void
		{
			if (state == INACTIVE)
			{
				state = EXTENDING;
			}
		}
		
		public function getMaxXRange():int
		{
			return maxDist + this.width;
		}
	}

}