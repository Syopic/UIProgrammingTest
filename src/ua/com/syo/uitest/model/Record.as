package ua.com.syo.uitest.model
{
	public class Record
	{
		public var category:String;
		public var subcategory:String;
		public var name:String;
		public var text:String;
		public var img:String;

		
		public function Record(category:String, subcategory:String, name:String, text:String = "", img:String = "")
		{
			this.category = category;
			this.subcategory = subcategory;
			this.name = name;
			this.text = text;
			this.img = img;
		}
	}
}