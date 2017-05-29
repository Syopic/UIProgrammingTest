package ua.com.syo.uitest.model
{
	public class Record
	{
		public var category:String;
		public var subcategory:String;
		public var name:String;
		
		public function Record(category:String, subcategory:String, name:String)
		{
			this.category = category;
			this.subcategory = subcategory;
			this.name = name;
		}
	}
}