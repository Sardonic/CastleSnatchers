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
	public class Escaper extends Entity implements IEventDispatcher
	{
		[Embed(source="../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Refugee_Running_1_strip2.png")]
		private const RUNNING:Class;
		
		[Embed(source = "../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Refugee_Impaled_1_strip2.png")]
		private const IMPALED:Class;
		
		public static const EXIT_SCREEN_EVENT:String = "Escaper Exited Screen";
		
		public var speed:Number;
		public var runAnim:Spritemap;
		public var impaleAnim:Spritemap;
		public var running:Boolean;
		public var skewered:Boolean;
		public var eventDispatcher:EventDispatcher;
		public static var changeHealth:Function;
		
		public function Escaper(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			runAnim = new Spritemap(RUNNING, 64, 101);
			impaleAnim = new Spritemap(IMPALED, 64, 101);
			eventDispatcher = new EventDispatcher(this);
			
			runAnim.add("run", [0, 1], 12, true);
			impaleAnim.add("impaled", [1], 0, false);
			
			runAnim.play("run");
			impaleAnim.play("impaled");
			
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
					//changeHealth(5);
					eventDispatcher.dispatchEvent(new Event(EXIT_SCREEN_EVENT));
					running = false;
				}
			}
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return eventDispatcher.willTrigger(type);
		}
		
		
	}

}