package ua.com.syo.uitest.view.components
{
	import flash.display.DisplayObjectContainer;
	
	public class VScrollBar extends ScrollBar
	{
		public function VScrollBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function=null)
		{
			super(Slider.VERTICAL, parent, xpos, ypos, defaultHandler);
		}
	}
}