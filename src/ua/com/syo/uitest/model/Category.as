package ua.com.syo.uitest.model
{
	public class Category implements ICategory
	{
		private var _name:String;
		private var _subcategories:Array = new Array();		
		private var _date:Date;		
		
		public function Category(name:String)
		{
			this._name = name;
			this._date = new Date();
		}
		
		public function get name():String {
			return _name;
		}
		
		public function addSubcategory(sub:SubCategory):void {
			_subcategories.push(sub);
		}
		
		public function getSubcategoryByName(name:String):SubCategory {
			var result:SubCategory = null;
			for (var i:int = 0; i < _subcategories.length; i++) 
			{
				if (_subcategories[i].name == name) result = _subcategories[i];
			}
			
			return result;
		}
		
		public function get subcategories():Array {
			return _subcategories;
		}
		
		public function get date():Date {
			return _date;
		}
		
		
	}
}