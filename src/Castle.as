package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Scott Barrett
	 */
	public class Castle extends Entity 
	{
		[Embed(source="../assets/img/Sick Paint ARt by LEAD DESIGNER/Sheets/Big_Castle_strip2.png")]
		public const img:Class;
		
		private var castleSheet:Spritemap;
		
		public function Castle(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			castleSheet = new Spritemap(img, 179, 432);
			castleSheet.add("open", [1], 0, false);
			castleSheet.add("closed", [0], 0, false);
			this.setHitbox(castleSheet.width, castleSheet.height);
			super(x, y, castleSheet, mask);
			castleSheet.play("closed");
			name = "castle";
		}
		
		public function setBase(x:Number, y:Number):void
		{
			this.x = x;
			this.y = (y - castleSheet.height);
		}
		
		public function open():void
		{
			castleSheet.play("open");
		}
		
		public function close():void
		{
			castleSheet.play("closed");
		}
	}

}