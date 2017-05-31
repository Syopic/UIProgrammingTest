package ua.com.syo.uitest.view.components
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TextArea extends Text
	{
		protected var _scrollbar:VScrollBar;
		
		public function TextArea(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, text:String="")
		{
			super(parent, xpos, ypos, text);
		}
		
		protected override function init() : void
		{
			super.init();
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			_scrollbar = new VScrollBar(this, 0, 0, onScrollbarScroll);
			_tf.addEventListener(Event.SCROLL, onTextScroll);
		}
		
		protected function updateScrollbar():void
		{
			var visibleLines:int = _tf.numLines - _tf.maxScrollV + 1;
			var percent:Number = visibleLines / _tf.numLines;
			_scrollbar.setSliderParams(1, _tf.maxScrollV, _tf.scrollV);
			_scrollbar.setThumbPercent(percent);
			_scrollbar.pageSize = visibleLines;
		}

		override public function draw():void
		{
			super.draw();
			
			_tf.width = _width - _scrollbar.width - 4;
			_scrollbar.x = _width - _scrollbar.width;
			_scrollbar.height = _height;
			_scrollbar.draw();
			addEventListener(Event.ENTER_FRAME, onTextScrollDelay);
		}
		
		protected function onTextScrollDelay(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onTextScrollDelay);
			updateScrollbar();
		}
		
		protected override function onChange(event:Event):void
		{
			super.onChange(event);
			updateScrollbar();
		}

		protected function onScrollbarScroll(event:Event):void
		{
			_tf.scrollV = Math.round(_scrollbar.value);
		}
		
		protected function onTextScroll(event:Event):void
		{
			_scrollbar.value = _tf.scrollV;
			updateScrollbar();
		}
		
		protected function onMouseWheel(event:MouseEvent):void
		{
			_scrollbar.value -= event.delta;
			_tf.scrollV = Math.round(_scrollbar.value);
		}

        public override function set enabled(value:Boolean):void
        {
            super.enabled = value;
            _tf.tabEnabled = value;
        }

        public function set autoHideScrollBar(value:Boolean):void
        {
            _scrollbar.autoHide = value;
        }
		
        public function get autoHideScrollBar():Boolean
        {
            return _scrollbar.autoHide;
        }

	}
}