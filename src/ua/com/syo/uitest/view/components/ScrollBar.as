package ua.com.syo.uitest.view.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	[Event(name="change", type="flash.events.Event")]
	public class ScrollBar extends Component
	{
		protected const DELAY_TIME:int = 500;
		protected const REPEAT_TIME:int = 100; 
		protected const UP:String = "up";
		protected const DOWN:String = "down";

        protected var _autoHide:Boolean = true;
		protected var _upButton:Button;
		protected var _downButton:Button;
		protected var _scrollSlider:ScrollSlider;
		protected var _orientation:String;
		protected var _lineSize:int = 1;
		protected var _delayTimer:Timer;
		protected var _repeatTimer:Timer;
		protected var _direction:String;
		protected var _shouldRepeat:Boolean = false;
		
		public function ScrollBar(orientation:String, parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function = null)
		{
			_orientation = orientation;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
		}
		
		override protected function addChildren():void
		{
			_scrollSlider = new ScrollSlider(_orientation, this, 0, 10, onChange);
			_upButton = new Button(this, 0, 0, "");
			_upButton.addEventListener(MouseEvent.MOUSE_DOWN, onUpClick);
			_upButton.setSize(10, 10);
			var upArrow:Shape = new Shape();
			_upButton.addChild(upArrow);
			
			_downButton = new Button(this, 0, 0, "");
			_downButton.addEventListener(MouseEvent.MOUSE_DOWN, onDownClick);
			_downButton.setSize(10, 10);
			var downArrow:Shape = new Shape();
			_downButton.addChild(downArrow);
			
			if(_orientation == Slider.VERTICAL)
			{
				upArrow.graphics.beginFill(Style.DROPSHADOW, 0.5);
				upArrow.graphics.moveTo(5, 3);
				upArrow.graphics.lineTo(7, 6);
				upArrow.graphics.lineTo(3, 6);
				upArrow.graphics.endFill();
				
				downArrow.graphics.beginFill(Style.DROPSHADOW, 0.5);
				downArrow.graphics.moveTo(5, 7);
				downArrow.graphics.lineTo(7, 4);
				downArrow.graphics.lineTo(3, 4);
				downArrow.graphics.endFill();
			}
			else
			{
				upArrow.graphics.beginFill(Style.DROPSHADOW, 0.5);
				upArrow.graphics.moveTo(3, 5);
				upArrow.graphics.lineTo(6, 7);
				upArrow.graphics.lineTo(6, 3);
				upArrow.graphics.endFill();
				
				downArrow.graphics.beginFill(Style.DROPSHADOW, 0.5);
				downArrow.graphics.moveTo(7, 5);
				downArrow.graphics.lineTo(4, 7);
				downArrow.graphics.lineTo(4, 3);
				downArrow.graphics.endFill();
			}
			
		}
		
		protected override function init():void
		{
			super.init();
			if(_orientation == Slider.HORIZONTAL)
			{
				setSize(100, 10);
			}
			else
			{
				setSize(10, 100);
			}
			_delayTimer = new Timer(DELAY_TIME, 1);
			_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayComplete);
			_repeatTimer = new Timer(REPEAT_TIME);
			_repeatTimer.addEventListener(TimerEvent.TIMER, onRepeat);
		}
		
		public function setSliderParams(min:Number, max:Number, value:Number):void
		{
			_scrollSlider.setSliderParams(min, max, value);
		}
		
		public function setThumbPercent(value:Number):void
		{
			_scrollSlider.setThumbPercent(value);
		}
		
		override public function draw():void
		{
			super.draw();
			if(_orientation == Slider.VERTICAL)
			{
				_scrollSlider.x = 0;
				_scrollSlider.y = 10;
				_scrollSlider.width = 10;
				_scrollSlider.height = _height - 20;
				_downButton.x = 0;
				_downButton.y = _height - 10;
			}
			else
			{
				_scrollSlider.x = 10;
				_scrollSlider.y = 0;
				_scrollSlider.width = _width - 20;
				_scrollSlider.height = 10;
				_downButton.x = _width - 10;
				_downButton.y = 0;
			}
			_scrollSlider.draw();
            if(_autoHide)
            {
                visible = _scrollSlider.thumbPercent < 1.0;
            }
            else
            {
                visible = true;
            }
		}

		public function set autoHide(value:Boolean):void
        {
            _autoHide = value;
            invalidate();
        }
        public function get autoHide():Boolean
        {
            return _autoHide;
        }

		public function set value(v:Number):void
		{
			_scrollSlider.value = v;
		}
		public function get value():Number
		{
			return _scrollSlider.value;
		}
		
		public function set minimum(v:Number):void
		{
			_scrollSlider.minimum = v;
		}
		public function get minimum():Number
		{
			return _scrollSlider.minimum;
		}
		
		public function set maximum(v:Number):void
		{
			_scrollSlider.maximum = v;
		}
		public function get maximum():Number
		{
			return _scrollSlider.maximum;
		}
		
		public function set lineSize(value:int):void
		{
			_lineSize = value;
		}
		public function get lineSize():int
		{
			return _lineSize;
		}
		
		public function set pageSize(value:int):void
		{
			_scrollSlider.pageSize = value;
			invalidate();
		}
		public function get pageSize():int
		{
			return _scrollSlider.pageSize;
		}

		protected function onUpClick(event:MouseEvent):void
		{
			goUp();
			_shouldRepeat = true;
			_direction = UP;
			_delayTimer.start();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
				
		protected function goUp():void
		{
			_scrollSlider.value -= _lineSize;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onDownClick(event:MouseEvent):void
		{
			goDown();
			_shouldRepeat = true;
			_direction = DOWN;
			_delayTimer.start();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function goDown():void
		{
			_scrollSlider.value += _lineSize;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			_delayTimer.stop();
			_repeatTimer.stop();
			_shouldRepeat = false;
		}
		
		protected function onChange(event:Event):void
		{
			dispatchEvent(event);
		}
		
		protected function onDelayComplete(event:TimerEvent):void
		{
			if(_shouldRepeat)
			{
				_repeatTimer.start();
			}
		}
		
		protected function onRepeat(event:TimerEvent):void
		{
			if(_direction == UP)
			{
				goUp();
			}
			else
			{
				goDown();
			}
		}
	}
}

