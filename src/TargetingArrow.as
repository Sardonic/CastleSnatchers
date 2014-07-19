package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class TargetingArrow extends Entity 
	{
		[Embed(source = "../assets/img/arrow_black.png")]
		private static const ARROW_BLACK:Class;
		
		private var target:Entity;
		private var arrowBlackImage:Image;
		
		public function TargetingArrow(x:Number=0, y:Number=0, mask:Mask=null) 
		{
			arrowBlackImage = new Image(ARROW_BLACK);
			super(x, y, arrowBlackImage, mask);
			target = null;
			this.layer = Layers.GUI;
			this.setHitbox(arrowBlackImage.width, arrowBlackImage.height);
		}
		
		public function bindToEntity(e:Entity):void
		{
			target = e;
			this.x = e.x + e.halfWidth - this.halfWidth;
			this.y = e.y - this.height - 5;
		}
		
		public function unbind():void
		{
			target = null;
		}
		
		public function getBoundEntity():Entity
		{
			return target;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (target)
			{
				this.x = target.x + target.halfWidth - this.halfWidth;
				this.y = target.y - this.height - 5;
			}
		}
	}

}