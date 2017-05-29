package ua.com.syo.uitest.view
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import ua.com.syo.uitest.components.Label;
	import ua.com.syo.uitest.components.List;
	import ua.com.syo.uitest.components.ListItem;
	import ua.com.syo.uitest.components.Style;
	import ua.com.syo.uitest.components.Window;
	import ua.com.syo.uitest.model.Category;
	import ua.com.syo.uitest.model.SubCategory;
	
	public class CategoryView extends Window
	{
		private var _categoryModel:Category;
		private var _titleLabel:Label;
		private var _lists:Array;
		
		
		public function CategoryView(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, width:Number = 100, category:Category = null)
		{
			this.width = width;
			_categoryModel = category;
			super(parent, xpos, ypos, _categoryModel.name);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			var yPos:int = 3;	
			_lists = new Array();
			for (var i:int = 0; i < _categoryModel.subcategories.length; i++) 
			{
				var sub:SubCategory = _categoryModel.subcategories[i];
				var label:Label = new Label(this, 10, yPos, sub.name);
				label.setTextFormat(new TextFormat(Style.fontName, Style.fontSize, 0xff0000))
				yPos+= 20;
				
				var _list:List = new List(this, 10, yPos, sub.items);
				_list.addEventListener(Event.SELECT, onListSelect)
				_list.setSize(width - 20, sub.items.length * 20);
				_lists.push(_list);
				for (var j:int = 0; j < sub.items.length; j++) 
				{
					//var subLab:Label = new Label(this, 30, yPos, sub.items[j]);
					yPos+= 20;
				}
				yPos+= 10;
				
			}
			
				
			/*_titleLabel = new Label(this, 10, 3, "Title Label");
			
			_list = new List(this, 10, 22, _items);
			_list.setSize(180, _list.items.length * 20);
			*/
			setSize(width, yPos + 20);
			draw();
		}
		
		public function clearSelection(event:Event):void
		{
			for (var i:int = 0; i < _lists.length; i++) 
			{
				if (tList != _lists[i])
				_lists[i].clearSelection();
			}
			tList = null;
		}
		
		public var tList:List;
		protected function onListSelect(event:Event):void
		{
			tList = event.currentTarget as List;
			dispatchEvent(event);
		}
	}
}