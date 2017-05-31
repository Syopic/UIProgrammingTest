 
package ua.com.syo.uitest.view.components
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    
    import ua.com.syo.uitest.view.components.Component;

	[Event(name="resize", type="flash.events.Event")]
	public class VBox extends Component
	{

		public function VBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
		}
		
		/**
		 * Override of addChild to force layout;
		 */
		override public function addChild(child:DisplayObject) : DisplayObject
		{
			super.addChild(child);
			child.addEventListener(Event.RESIZE, onResize);
			draw();
			return child;
		}

		/**
		 * Override of addChildAt to force layout;
		 */
		override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
		{
			super.addChildAt(child, index);
			child.addEventListener(Event.RESIZE, onResize);
			draw();
			return child;
		}

        /**
         * Override of removeChild to force layout;
         */
        override public function removeChild(child:DisplayObject):DisplayObject
        {
            super.removeChild(child);            
            child.removeEventListener(Event.RESIZE, onResize);
            draw();
            return child;
        }
		
        /**
         * Override of removeChild to force layout;
         */
        override public function removeChildAt(index:int):DisplayObject
        {
            var child:DisplayObject = super.removeChildAt(index);
            child.removeEventListener(Event.RESIZE, onResize);
            draw();
            return child;
        }

		/**
		 * Internal handler for resize event of any attached component. Will redo the layout based on new size.
		 */
		protected function onResize(event:Event):void
		{
			invalidate();
		}
		
		/**
		 * Draws the visual ui of the component, in this case, laying out the sub components.
		 */
		override public function draw() : void
		{
			_width = 0;
			_height = 0;
			var ypos:Number = 0;
			for(var i:int = 0; i < numChildren; i++)
			{
				var child:DisplayObject = getChildAt(i);
				child.y = ypos;
				ypos += child.height;
				_height += child.height;
				_width = Math.max(_width, child.width);
			}
		}
	}
}