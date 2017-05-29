
package ua.com.syo.uitest.components
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import ua.com.syo.uitest.model.Record;
	
	public class Accordion extends Component
	{
		protected var _parent:DisplayObjectContainer;
		
		protected var _windows:Array;
		protected var _winWidth:Number = 100;
		protected var _winHeight:Number = 100;
		protected var _vbox:VBox;
		
		public function Accordion(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			_parent = parent;
			super(parent, xpos, ypos);
		}
		
		protected override function addChildren() : void
		{
			_vbox = new VBox(this);
			_windows = new Array();
		}
		
		public function setData(list:Vector.<Record>):void
		{
			for (var i:int = 0; i < list.length; i++) 
			{
				
			}
			
		}
		
		public function addCategory(window:Window, index):void
		{
			// check index range
			index = Math.min(index, _windows.length);
			index = Math.max(index, 0);
			
			_vbox.addChild(window);
			
			window.minimized = false;
			window.addEventListener(Event.SELECT, onWindowSelect);
			
			_windows.push(window);
		}
		
		override public function draw():void
		{
			for(var i:int = 0; i < _windows.length; i++)
			{
				_windows[i].setSize(_winWidth, _windows[i].height);
				_vbox.draw();
			}
		}

		protected function onWindowSelect(event:Event):void
		{
			var window:Window = event.target as Window;
			window.minimized = !window.minimized;
			if (_parent is Component)(_parent as Component).draw();
		}
		
		public override function set width(w:Number):void
		{
			_winWidth = w;
			super.width = w;
		}
		
		public override function set height(h:Number):void
		{
			_winHeight = h - (_windows.length) * 20;
			super.height = h;
		}
		
	}
}