package ua.com.syo.uitest.view.components
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this ScrollBar.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
	 */
	public class _HScrollBar extends ScrollBar
	{
		public function _HScrollBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function=null)
		{
			super(Slider.HORIZONTAL, parent, xpos, ypos, defaultHandler);
		}
	}
}