package ua.com.syo.uitest.view.components {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name = "select", type = "flash.events.Event")]
	public class List extends Component {
		protected var _items:Array;
		protected var _itemHolder:Sprite;
		protected var _panel:Panel;
		protected var _listItemHeight:Number = 20;
		protected var _listItemClass:Class = ListItem;
		protected var _selectedIndex:int = -1;
		protected var _defaultColor:uint = Style.TEXT_BACKGROUND;
		protected var _alternateColor:uint = Style.LIST_ALTERNATE;
		protected var _selectedColor:uint = Style.LIST_SELECTED;
		protected var _rolloverColor:uint = Style.LIST_ROLLOVER;
		protected var _alternateRows:Boolean = false;

		public function List(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, items:Array = null) {
			if (items != null) {
				_items = items;
			} else {
				_items = new Array();
			}
			super(parent, xpos, ypos);
		}

		protected override function init():void {
			super.init();
			//setSize(100, 100);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			addEventListener(Event.RESIZE, onResize);
			makeListItems();
			fillItems();

		}

		protected override function addChildren():void {
			super.addChildren();
			_panel = new Panel(this, 0, 0);
			_itemHolder = new Sprite();
			_panel.content.addChild(_itemHolder);
		}

		protected function makeListItems():void {
			var item:ListItem;
			while (_itemHolder.numChildren > 0) {
				item = ListItem(_itemHolder.getChildAt(0));
				item.removeEventListener(MouseEvent.CLICK, onSelect);
				_itemHolder.removeChildAt(0);
			}

			var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length);
			numItems = Math.max(numItems, 1);
			for (var i:int = 0; i < numItems; i++) {

				item = new _listItemClass(_itemHolder, 0, i * _listItemHeight);
				item.setSize(width, _listItemHeight);
				item.defaultColor = _defaultColor;

				item.selectedColor = _selectedColor;
				item.rolloverColor = _rolloverColor;
				item.addEventListener(MouseEvent.CLICK, onSelect);
			}
		}

		protected function fillItems():void {
			var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length);
			for (var i:int = 0; i < numItems; i++) {
				var item:ListItem = _itemHolder.getChildAt(i) as ListItem;
				item.data = _items[i];
				if (i < _items.length) {
					item.data = _items[i].name;
				} else {
					item.data = "";
				}
				if (_alternateRows) {
					item.defaultColor = ((i) % 2 == 0) ? _defaultColor : _alternateColor;
				} else {
					item.defaultColor = _defaultColor;
				}
				if (i == _selectedIndex) {
					item.selected = true;
				} else {
					item.selected = false;
				}
			}
		}

		public override function draw():void {
			super.draw();
			_selectedIndex = Math.min(_selectedIndex, _items.length - 1);

			_panel.setSize(_width, _items.length * _listItemHeight);
			_panel.color = _defaultColor;
			_panel.draw();

		}

		public function addItem(item:Object):void {
			_items.push(item);
			invalidate();
			makeListItems();
			fillItems();
		}

		public function addItemAt(item:Object, index:int):void {
			index = Math.max(0, index);
			index = Math.min(_items.length, index);
			_items.splice(index, 0, item);
			invalidate();
			makeListItems();
			fillItems();
		}

		public function removeItem(item:Object):void {
			var index:int = _items.indexOf(item);
			removeItemAt(index);
		}

		public function removeItemAt(index:int):void {
			if (index < 0 || index >= _items.length) {
				return;
			}
			_items.splice(index, 1);
			invalidate();
			makeListItems();
			fillItems();
		}

		public function removeAll():void {
			_items.length = 0;
			invalidate();
			makeListItems();
			fillItems();
		}

		protected function onSelect(event:Event):void {
			if (!(event.target is ListItem)) {
				return;
			}

			for (var i:int = 0; i < _itemHolder.numChildren; i++) {
				if (_itemHolder.getChildAt(i) == event.target) {
					_selectedIndex = i;
				}
				ListItem(_itemHolder.getChildAt(i)).selected = false;
			}
			ListItem(event.target).selected = true;
			dispatchEvent(new Event(Event.SELECT));
		}

		public function clearSelection():void {
			for (var i:int = 0; i < _itemHolder.numChildren; i++) {
				ListItem(_itemHolder.getChildAt(i)).selected = false;
				_selectedIndex = -1;
			}
		}

		protected function onScroll(event:Event):void {
			fillItems();
		}

		protected function onMouseWheel(event:MouseEvent):void {
			fillItems();
		}

		protected function onResize(event:Event):void {
			makeListItems();
			fillItems();
		}

		public function set selectedIndex(value:int):void {
			if (value >= 0 && value < _items.length) {
				_selectedIndex = value;
					//				_scrollbar.value = _selectedIndex;
			} else {
				_selectedIndex = -1;
			}
			invalidate();
			dispatchEvent(new Event(Event.SELECT));
		}

		public function get selectedIndex():int {
			return _selectedIndex;
		}

		public function set selectedItem(item:Object):void {
			var index:int = _items.indexOf(item);
			//			if(index != -1)
			//			{
			selectedIndex = index;
			invalidate();
			dispatchEvent(new Event(Event.SELECT));
			//			}
		}

		public function get selectedItem():Object {
			if (_selectedIndex >= 0 && _selectedIndex < _items.length) {
				return _items[_selectedIndex];
			}
			return null;
		}

		public function set defaultColor(value:uint):void {
			_defaultColor = value;
			invalidate();
		}

		public function get defaultColor():uint {
			return _defaultColor;
		}

		public function set selectedColor(value:uint):void {
			_selectedColor = value;
			invalidate();
		}

		public function get selectedColor():uint {
			return _selectedColor;
		}

		public function set rolloverColor(value:uint):void {
			_rolloverColor = value;
			invalidate();
		}

		public function get rolloverColor():uint {
			return _rolloverColor;
		}

		public function set listItemHeight(value:Number):void {
			_listItemHeight = value;
			makeListItems();
			invalidate();
		}

		public function get listItemHeight():Number {
			return _listItemHeight;
		}

		public function set items(value:Array):void {
			_items = value;
			invalidate();
		}

		public function get items():Array {
			return _items;
		}

		public function set listItemClass(value:Class):void {
			_listItemClass = value;
			makeListItems();
			invalidate();
		}

		public function get listItemClass():Class {
			return _listItemClass;
		}

		public function set alternateColor(value:uint):void {
			_alternateColor = value;
			invalidate();
		}

		public function get alternateColor():uint {
			return _alternateColor;
		}

		public function set alternateRows(value:Boolean):void {
			_alternateRows = value;
			invalidate();
		}

		public function get alternateRows():Boolean {
			return _alternateRows;
		}

	}
}
