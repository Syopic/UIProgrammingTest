
package ua.com.syo.uitest.view.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class Panel extends Component
	{
		protected var _mask:Sprite;
		protected var _background:Sprite;
		protected var _color:int = -1;
		protected var _shadow:Boolean = true;
		
		public var content:Sprite;

		public function Panel(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function init():void
		{
			super.init();
			setSize(100, 100);
		}

		override protected function addChildren():void
		{
			_background = new Sprite();
			super.addChild(_background);
			
			_mask = new Sprite();
			_mask.mouseEnabled = false;
			super.addChild(_mask);
			
			content = new Sprite();
			super.addChild(content);
			content.mask = _mask;
			
			filters = [getShadow(2, true)];
		}
		
		public override function addChild(child:DisplayObject):DisplayObject
		{
			content.addChild(child);
			return child;
		}
		

		public function addRawChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			return child;
		}

		override public function draw():void
		{
			super.draw();
			_background.graphics.clear();
			_background.graphics.lineStyle(1, 0, 0.1);
			if(_color == -1)
			{
				_background.graphics.beginFill(Style.PANEL);
			}
			else
			{
				_background.graphics.beginFill(_color);
			}
			_background.graphics.drawRect(0, 0, _width, _height);
			_background.graphics.endFill();
			
			
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
		}
		
		public function get shadow():Boolean
		{
			return _shadow;
		}
		
		public function set color(c:int):void
		{
			_color = c;
			invalidate();
		}
		public function get color():int
		{
			return _color;
		}
	}
}