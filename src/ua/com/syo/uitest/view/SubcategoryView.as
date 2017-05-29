package ua.com.syo.uitest.view
{
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import ua.com.syo.uitest.components.Label;
	import ua.com.syo.uitest.components.List;
	import ua.com.syo.uitest.components.Panel;
	
	public class SubcategoryView extends Panel
	{
		
		private var _titleLabel:Label;
		private var _list:List;
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ScrollPane.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function SubcategoryView(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		/**
		 * Initializes this component.
		 */
		override protected function init():void
		{
			super.init();
			addEventListener(Event.RESIZE, onResize);
			invalidate();
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
			_titleLabel = new Label(this, 3, 3, "Title Label");
			
			_list = new List(this, 5, 20, ["Item1", "Item2", "Item3", "Item4", "Item3", "Item4"]);
			
			_list.setSize(200, 6*20)
			height = 20 + 6*20;
		}
		
		

		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();

		}
		
		/**
		 * Updates the scrollbars when content is changed. Needs to be done manually.
		 */
		public function update():void
		{
			invalidate();
			
		}
		
		
		protected function onResize(event:Event):void
		{
			invalidate();
		}

	}
}