package ua.com.syo.uitest.view.components
{
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScrollPane extends Panel
	{
		protected var _vScrollbar:VScrollBar;
		

		public function ScrollPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function init():void
		{
			super.init();
			addEventListener(Event.RESIZE, onResize);
			setSize(100, 100);
		}

		override protected function addChildren():void
		{
			super.addChildren();
			_vScrollbar = new VScrollBar(null, width - 10, 0, onScroll);
			addRawChild(_vScrollbar);
		}
		
		override public function draw():void
		{
			super.draw();
			
			var vPercent:Number = (_height - 10) / content.height;
			
			_vScrollbar.x = width;
			_vScrollbar.height = height;
			_mask.height = height;
			_vScrollbar.setThumbPercent(vPercent);
			_vScrollbar.maximum = Math.max(0, content.height - _height);
			_vScrollbar.pageSize = _height - 10;
			
			content.y = -_vScrollbar.value;
		}
		
		protected function onScroll(event:Event):void
		{
			content.y = -_vScrollbar.value;
		}
		
		protected function onResize(event:Event):void
		{
			invalidate();
		}
		
		protected function onMouseGoDown(event:MouseEvent):void
		{
			content.startDrag(false, new Rectangle(0, 0, Math.min(0, _width - content.width - 10), Math.min(0, _height - content.height - 10)));
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			_vScrollbar.value = -content.y;
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			content.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
	}
}