package ua.com.syo.uitest.components
{
	import flash.display.DisplayObjectContainer;
	
	public class Category extends Window
	{
		private var _titleLabel:Label;
		private var _list:List;
		private var _items:Array;
		
		
		public function Category(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, title:String="Window", items:Array = null)
		{
			if(items != null)
				_items = items;
			else
				_items = new Array();
			
			super(parent, xpos, ypos, title);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			_titleLabel = new Label(this, 10, 3, "Title Label");
			
			_list = new List(this, 10, 22, _items);
			_list.setSize(180, _list.items.length * 20);
			
			setSize(width, 50 + _list.height);
			draw();
		}
	}
}