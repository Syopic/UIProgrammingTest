package ua.com.syo.uitest.model
{
	public class Item
	{
		private var _name:String;
		private var _img:String;
		private var _text:String;
		
		
		public function Item(name:String, text:String, img:String, date:Date = null)
		{
			this._name = name;
			this._text = text;
			this._img = img;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function get text():String {
			return _text;
		}
		
		public function get img():String {
			return _img;
		}
		
		
		
	}
}