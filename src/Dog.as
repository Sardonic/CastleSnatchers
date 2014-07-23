package  
{
	import flash.events.Event;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Dog extends EventfulEntity 
	{
		[Embed(source = "../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Dog_Running_strip3.png")]
		private static const RUNNING:Class;
		
		private var runAnim:Spritemap;
		private var chaseSpeed:Number;
		private var dragSpeed:Number;
		private var target:Escaper;
		private var state:int;
		
		private static const CHASING_STATE:int = 0;
		private static const RUNNING_OFFSCREEN_STATE:int = 1
		private static const DRAGGING_STATE:int = 2;
		
		static public const RETRIEVED_ESCAPER:String = "retrievedEscaper";
		
		public function Dog(target:Escaper, x:Number=0, y:Number=0) 
		{
			runAnim = new Spritemap(RUNNING, getWidth(), getHeight());
			setHitbox(getWidth(), getHeight());
			runAnim.add("run", [0, 1, 2], 12);
			runAnim.play("run");
			this.target = target;
			target.addEventListener(Escaper.EXIT_SCREEN_EVENT, onTargetEscape);
			state = CHASING_STATE;
			
			chaseSpeed = 400;
			dragSpeed = 150;
			layer = Layers.FRONT_CASTLE;
			
			
			super(x, y, runAnim);
		}
		
		private function onTargetEscape(e:Event):void 
		{
			target = null;
			
			state = RUNNING_OFFSCREEN_STATE;
		}
		
		override public function update():void 
		{
			super.update();
			
			switch (state)
			{
				case CHASING_STATE:
					chase();
					break;
				case RUNNING_OFFSCREEN_STATE:
					runOffscreen();
					break;
				case DRAGGING_STATE:
					drag();
					break;
			}
		}
		
		private function chase():void 
		{
			this.x += chaseSpeed * FP.elapsed;
			
			if (collideWith(target, x, y))
			{
				target.die();
				state = DRAGGING_STATE;
			}
		}
		
		private function runOffscreen():void 
		{
			this.x += chaseSpeed * FP.elapsed;
			
			if (this.x >= FP.width)
			{
				state = DRAGGING_STATE;
			}
		}
		
		private function drag():void 
		{
			this.x -= dragSpeed * FP.elapsed;
			
			if (this.x < -this.width)
			{
				this.world.remove(this);
				
				// fire some events, too
				dispatchEvent(new Event(RETRIEVED_ESCAPER));
			}
		}
		
		public static function getWidth():int
		{
			return 140;
		}
		
		public static function getHeight():int
		{
			return 85;
		}
	}

}