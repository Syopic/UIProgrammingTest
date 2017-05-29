package ua.com.syo.uitest.model
{
	public class Record
	{
		private var category:String;
		private var subcategory:String;
		private var name:String;
		
		public function Record(category:String, subcategory:String, name:String)
		{
			this.category = category;
			this.subcategory = subcategory;
			this.name = name;
		}
	}
}