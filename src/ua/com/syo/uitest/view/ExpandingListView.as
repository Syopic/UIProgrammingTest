
package ua.com.syo.uitest.view {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import ua.com.syo.uitest.components.Component;
	import ua.com.syo.uitest.components.List;
	import ua.com.syo.uitest.components.ScrollPane;
	import ua.com.syo.uitest.components.VBox;
	import ua.com.syo.uitest.components.Window;
	import ua.com.syo.uitest.model.Category;
	import ua.com.syo.uitest.model.Item;

	public class ExpandingListView extends Component {
		protected var _panel:ScrollPane;
		protected var _views:Array;
		protected var _winWidth:Number = 100;
		protected var _winHeight:Number = 100;
		protected var _vbox:VBox;
		protected var _subIsShow:Boolean = true;
		protected var _selectedItem:Item;

		public function ExpandingListView(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos);
		}
		
		public function setData(list:Array):void {
			// clear
			_selectedItem = null;
			if (_views.length > 0) {
				for (var i:int = 0; i < _views.length; i++) {
					_views[i].removeEventListener(Event.CHANGE, onWindowSelect);
					_views[i].removeEventListener(Event.SELECT, onItemSelect);
					_vbox.removeChild(_views[i]);
					_views[i] = null;
				}
				_views = new Array();
			}
			for (i = 0; i < list.length; i++) {
				addCategory(list[i], i);
			}
		}
		
		private function addCategory(category:Category, index:int):void {
			
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

		protected override function addChildren():void {
			_panel = new ScrollPane(this, 0, 0);
			_vbox = new VBox(_panel);
			_views = new Array();
		}

		override public function draw():void {
			_vbox.draw();
			_panel.draw();
		}

		protected function onWindowSelect(event:Event):void {
			var view:Window = event.target as Window;
			if (_subIsShow) view.minimized = !view.minimized;
			draw();
		}

		protected function onItemSelect(event:Event):void {
			_selectedItem = (event.currentTarget.tList as List).selectedItem as Item;
			for (var i:int = 0; i < _views.length; i++) {
				(_views[i] as CategoryView).clearSelection(event);
			}
			dispatchEvent(new Event(Event.SELECT));
		}

		public override function setSize(w:Number, h:Number):void {
			width = w;
			height = h;
			_panel.setSize(w, h);
			this.draw();
		}

		public override function set width(w:Number):void {
			_winWidth = w;
			super.width = w;
		}

		public override function set height(h:Number):void {
			_winHeight = h - (_views.length) * 20;
			super.height = h;
		}

		public function get selectedItem():Item {
			return _selectedItem;
		}
		
		public function set subcategoryVisible(value:Boolean):void {
			this._subIsShow = value;
			if (!value) {
				for (var i:int = 0; i < _views.length; i++) {
					var view:CategoryView = (_views[i] as CategoryView);
					view.minimized = true;
				}
			}
			draw();
		}

	}
}
