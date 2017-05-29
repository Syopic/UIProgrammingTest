package ua.com.syo.uitest.model
{
	import flash.utils.Dictionary;

	public class DataStorage
	{
		private static var itemsDictionary:Dictionary = new Dictionary();
		private static var categoriesDictionary:Dictionary = new Dictionary();
		
		public static function setData(data:Array):void {
			for (var i:int = 0; i < data.length; i++) {
				itemsDictionary[data[i].name] = new Record(data[i].category, data[i].subcategory, data[i].name);
				
				if (!categoriesDictionary[data[i].category]) {
					categoriesDictionary[data[i].category] = new Category(data[i].category);
				}
				
				var cat:Category = categoriesDictionary[data[i].category];
				var sub:SubCategory = cat.getSubcategoryByName(data[i].subcategory);
				var str:String = data[i].name;
				
				if (sub == null) {
					sub = new SubCategory(data[i].subcategory);
					cat.addSubcategory(sub);
				}
				sub.addItem(str);
			}
		}
		
		public static function getItems(categoryName:String, subCategoryName:String):Array {
			var result:Array = [];
			for each (var record:Record in itemsDictionary) {
				if (record.name == categoryName && record.subcategory == subCategoryName) {
					result.push(record);
				}
			}
			return result;
		}
		
		public static function getCategories():Array {
			var result:Array = [];
			for each (var cat:Category in categoriesDictionary) {
				result.push(cat);
			}
			return result;
		}
		
		public static function getItemByName(name:String):Record {
			return itemsDictionary[name];
		}
		
		public static function getCategoryByName(name:String):Category {
			return categoriesDictionary[name];
		}
	}
}