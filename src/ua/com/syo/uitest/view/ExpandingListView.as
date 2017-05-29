
package ua.com.syo.uitest.view
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import ua.com.syo.uitest.components.Component;
	import ua.com.syo.uitest.components.List;
	import ua.com.syo.uitest.components.VBox;
	import ua.com.syo.uitest.components.Window;
	import ua.com.syo.uitest.model.Category;
	
	public class ExpandingListView extends Component
	{
		protected var _parent:DisplayObjectContainer;
		
		protected var _views:Array;
		protected var _winWidth:Number = 100;
		protected var _winHeight:Number = 100;
		protected var _vbox:VBox;
		
		public function ExpandingListView(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			_parent = parent;
			super(parent, xpos, ypos);
		}
		
		protected override function addChildren() : void
		{
			_vbox = new VBox(this);
			_views = new Array();
		}
		
		public function setData(list:Array):void
		{
			for (var i:int = 0; i < list.length; i++) 
			{
				addCategory(list[i], i);
			}
		}
		
		public function addCategory(category:Category, index:int):void
		{
			var categoryView:CategoryView = new CategoryView(null, 0, 0, _winWidth, category);
			// check index range
			index = Math.min(index, _views.length);
			index = Math.max(index, 0);
			
			_vbox.addChildAt(categoryView, index);
			
			categoryView.minimized = false;
			categoryView.addEventListener(Event.CHANGE, onWindowSelect);
			categoryView.addEventListener(Event.SELECT, onItemSelect);
			
			
			_views.push(categoryView);
		}
		
		override public function draw():void
		{
			for(var i:int = 0; i < _views.length; i++)
			{
				_views[i].setSize(_winWidth, _views[i].height);
				_vbox.draw();
			}
		}

		protected function onWindowSelect(event:Event):void
		{
			var view:Window = event.target as Window;
			view.minimized = !view.minimized;
			if (_parent is Component)(_parent as Component).draw();
		}
		
		protected function onItemSelect(event:Event):void
		{
			for(var i:int = 0; i < _views.length; i++)
			{
				(_views[i] as CategoryView).clearSelection(event);
			}
		}
		
		public override function set width(w:Number):void
		{
			_winWidth = w;
			super.width = w;
		}
		
		public override function set height(h:Number):void
		{
			_winHeight = h - (_views.length) * 20;
			super.height = h;
		}
		
	}
}