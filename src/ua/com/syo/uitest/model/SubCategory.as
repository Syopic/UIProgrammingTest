package ua.com.syo.uitest.model
{
	public class SubCategory
	{
		private var _name:String;
		private var _items:Array = new Array;		
		
		public function SubCategory(name:String)
		{
			this._name = name;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function addItem(item:Item):void {
			_items.push(item);
		}
		
		public function get items():Array {
			return _items;
		}
		
		
	}
}