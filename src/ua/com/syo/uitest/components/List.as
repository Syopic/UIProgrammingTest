﻿package ua.com.syo.uitest.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="select", type="flash.events.Event")]
	public class List extends Component
	{
		protected var _items:Array;
		protected var _itemHolder:Sprite;
		protected var _panel:Panel;
		protected var _listItemHeight:Number = 20;
		protected var _listItemClass:Class =ListItem;
		protected var _selectedIndex:int = -1;
		protected var _defaultColor:uint = Style.LIST_DEFAULT;
		protected var _alternateColor:uint = Style.LIST_ALTERNATE;
		protected var _selectedColor:uint = Style.LIST_SELECTED;
		protected var _rolloverColor:uint = Style.LIST_ROLLOVER;
		protected var _alternateRows:Boolean = false;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this List.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param items An array of items to display in the list. Either strings or objects with label property.
		 */
		public function List(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, items:Array=null)
		{
			if(items != null)
			{
				_items = items;
			}
			else
			{
				_items = new Array();
			}
			super(parent, xpos, ypos);
		}
		
		/**
		 * Initilizes the component.
		 */
		protected override function init() : void
		{
			super.init();
			//setSize(100, 100);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
            addEventListener(Event.RESIZE, onResize);
            makeListItems();
            fillItems();
			
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		protected override function addChildren() : void
		{
			super.addChildren();
			_panel = new Panel(this, 0, 0);
			_panel.color = 0xff0000;
			_itemHolder = new Sprite();
			_panel.content.addChild(_itemHolder);
		}
		
		/**
		 * Creates all the list items based on data.
		 */
		protected function makeListItems():void
		{
			var item:ListItem;
			while(_itemHolder.numChildren > 0)
			{
				item = ListItem(_itemHolder.getChildAt(0));
				item.removeEventListener(MouseEvent.CLICK, onSelect);
				_itemHolder.removeChildAt(0);
			}

            var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length);
            numItems = Math.max(numItems, 1);
			for(var i:int = 0; i < numItems; i++)
			{

				item = new _listItemClass(_itemHolder, 0, i * _listItemHeight);
				item.setSize(width, _listItemHeight);
				item.defaultColor = _defaultColor;

				item.selectedColor = _selectedColor;
				item.rolloverColor = _rolloverColor;
				item.addEventListener(MouseEvent.CLICK, onSelect);
			}
		}

		
        protected function fillItems():void
        {
            var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length);
            for(var i:int = 0; i < numItems; i++)
            {
                var item:ListItem = _itemHolder.getChildAt(i) as ListItem;
				item.data = _items[i];
				if(i < _items.length)
				{
	                item.data = _items[i];
				}
				else
				{
					item.data = "";
				}
				if(_alternateRows)
				{
					item.defaultColor = ((i) % 2 == 0) ? _defaultColor : _alternateColor;
				}
				else
				{
					item.defaultColor = _defaultColor;
				}
                if(i == _selectedIndex)
                {
                    item.selected = true;
                }
                else
                {
                    item.selected = false;
                }
            }
        }
		
		/**
		 * If the selected item is not in view, scrolls the list to make the selected item appear in the view.
		 */
		
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw() : void
		{
			super.draw();
			
			_selectedIndex = Math.min(_selectedIndex, _items.length - 1);


			// panel
			_panel.setSize(_width, _items.length * _listItemHeight);
			_panel.color = _defaultColor;
			_panel.draw();
			
			// scrollbar
			/*_scrollbar.x = _width - 10;
			var contentHeight:Number = _items.length * _listItemHeight;
			_scrollbar.setThumbPercent(_height / contentHeight); 
			var pageSize:Number = Math.floor(_height / _listItemHeight);
            _scrollbar.maximum = Math.max(0, _items.length - pageSize);
			_scrollbar.pageSize = pageSize;
			_scrollbar.height = _height;
			_scrollbar.draw();
            scrollToSelection();*/
		}
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_items.push(item);
			invalidate();
			makeListItems();
      fillItems();
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			index = Math.max(0, index);
			index = Math.min(_items.length, index);
			_items.splice(index, 0, item);
			invalidate();
      makeListItems();
      fillItems();
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			var index:int = _items.indexOf(item);
			removeItemAt(index);
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			if(index < 0 || index >= _items.length) return;
			_items.splice(index, 1);
			invalidate();
      makeListItems();
      fillItems();
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			_items.length = 0;
			invalidate();
      makeListItems();
      fillItems();
		}
		
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when a user selects an item in the list.
		 */
		protected function onSelect(event:Event):void
		{
			if(! (event.target is ListItem)) return;
			
			for(var i:int = 0; i < _itemHolder.numChildren; i++)
			{
				if(_itemHolder.getChildAt(i) == event.target) _selectedIndex = i;
				ListItem(_itemHolder.getChildAt(i)).selected = false;
			}
			ListItem(event.target).selected = true;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		/**
		 * Called when the user scrolls the scroll bar.
		 */
		protected function onScroll(event:Event):void
		{
            fillItems();
		}
		
		/**
		 * Called when the mouse wheel is scrolled over the component.
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
            fillItems();
		}

        protected function onResize(event:Event):void
        {
            makeListItems();
            fillItems();
        }
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the index of the selected list item.
		 */
		public function set selectedIndex(value:int):void
		{
			if(value >= 0 && value < _items.length)
			{
				_selectedIndex = value;
//				_scrollbar.value = _selectedIndex;
			}
			else
			{
				_selectedIndex = -1;
			}
			invalidate();
			dispatchEvent(new Event(Event.SELECT));
		}
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		/**
		 * Sets / gets the item in the list, if it exists.
		 */
		public function set selectedItem(item:Object):void
		{
			var index:int = _items.indexOf(item);
//			if(index != -1)
//			{
				selectedIndex = index;
				invalidate();
				dispatchEvent(new Event(Event.SELECT));
//			}
		}
		public function get selectedItem():Object
		{
			if(_selectedIndex >= 0 && _selectedIndex < _items.length)
			{
				return _items[_selectedIndex];
			}
			return null;
		}

		/**
		 * Sets/gets the default background color of list items.
		 */
		public function set defaultColor(value:uint):void
		{
			_defaultColor = value;
			invalidate();
		}
		public function get defaultColor():uint
		{
			return _defaultColor;
		}

		/**
		 * Sets/gets the selected background color of list items.
		 */
		public function set selectedColor(value:uint):void
		{
			_selectedColor = value;
			invalidate();
		}
		public function get selectedColor():uint
		{
			return _selectedColor;
		}

		/**
		 * Sets/gets the rollover background color of list items.
		 */
		public function set rolloverColor(value:uint):void
		{
			_rolloverColor = value;
			invalidate();
		}
		public function get rolloverColor():uint
		{
			return _rolloverColor;
		}

		/**
		 * Sets the height of each list item.
		 */
		public function set listItemHeight(value:Number):void
		{
			_listItemHeight = value;
            makeListItems();
			invalidate();
		}
		public function get listItemHeight():Number
		{
			return _listItemHeight;
		}

		/**
		 * Sets / gets the list of items to be shown.
		 */
		public function set items(value:Array):void
		{
			_items = value;
			invalidate();
		}
		public function get items():Array
		{
			return _items;
		}

		/**
		 * Sets / gets the class used to render list items. Must extend ListItem.
		 */
		public function set listItemClass(value:Class):void
		{
			_listItemClass = value;
			makeListItems();
			invalidate();
		}
		public function get listItemClass():Class
		{
			return _listItemClass;
		}

		/**
		 * Sets / gets the color for alternate rows if alternateRows is set to true.
		 */
		public function set alternateColor(value:uint):void
		{
			_alternateColor = value;
			invalidate();
		}
		public function get alternateColor():uint
		{
			return _alternateColor;
		}
		
		/**
		 * Sets / gets whether or not every other row will be colored with the alternate color.
		 */
		public function set alternateRows(value:Boolean):void
		{
			_alternateRows = value;
			invalidate();
		}
		public function get alternateRows():Boolean
		{
			return _alternateRows;
		}

	}
}