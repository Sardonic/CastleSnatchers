package  
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
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
	public class Escaper extends EventfulEntity
	{
		[Embed(source="../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Refugee_Running_1_strip2.png")]
		private const RUNNING:Class;
		
		[Embed(source = "../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Refugee_Impaled_1_strip2.png")]
		private const IMPALED:Class;
		
		public static const EXIT_SCREEN_EVENT:String = "Escaper Exited Screen";
		public static const EXIT_HARPOON_RANGE_EVENT:String = "Escaper Left Harpoon Range";
		public static const DYING_EVENT:String = "Escaper Dying";
		
		public var speed:Number;
		public var runAnim:Spritemap;
		public var impaleAnim:Spritemap;
		public var running:Boolean;
		public var skewered:Boolean;
		private var outOfHarpoonRange:Boolean;
		
		public function Escaper(x:Number=0, y:Number=0) 
		{
			runAnim = new Spritemap(RUNNING, getWidth(), getHeight());
			impaleAnim = new Spritemap(IMPALED, getWidth(), getHeight());
			
			runAnim.add("run", [0, 1], 12, true);
			impaleAnim.add("impaled", [1], 0, false);
			
			runAnim.play("run");
			impaleAnim.play("impaled");
			
			layer = Layers.FRONT_CASTLE;
			
			speed = 100;
			running = true;
			skewered = false;
			
			this.type = "Renegade";
			
			this.setHitbox(runAnim.width, runAnim.height);
			
			outOfHarpoonRange = false;
			
			super(x, y, runAnim, mask);
		}
		
		public function setBase(x:Number, y:Number):void
		{
			this.x = x;
			this.y = (y - this.height);
		}
		
		public function skewer():void
		{
			running = false;
			graphic = impaleAnim;
		}
		
		override public function update():void 
		{
			super.update();
			
			
			if (running)
			{
				x += speed * FP.elapsed;
				if (x >= FP.width)
				{
					dispatchEvent(new Event(EXIT_SCREEN_EVENT));
					running = false;
					die();
				}
				else
				{
					if (!outOfHarpoonRange)
					{
						var harpoon:Harpoon = this.world.getInstance("harpoon") as Harpoon;
						
						if (harpoon && harpoon.getMaxXRange() < this.x)
						{
							dispatchEvent(new Event(EXIT_HARPOON_RANGE_EVENT));
							outOfHarpoonRange = true;
						}
					}
				}
			}
			
		}
		
		public function die():void
		{
			dispatchEvent(new Event(DYING_EVENT));
			active = false;
			visible = false;
			this.world.remove(this);
		}
		
		public static function getHeight():uint
		{
			return 101;
		}
		
		public static function getWidth():uint
		{
			return 64;
		}
	}

}