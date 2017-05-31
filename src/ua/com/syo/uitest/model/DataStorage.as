package ua.com.syo.uitest.model
{
	import flash.utils.Dictionary;
	/**
	 * simple data class with helpers
	 */
	public class DataStorage
	{
		private static var itemsDictionary:Dictionary = new Dictionary();
		private static var categoriesDictionary:Dictionary = new Dictionary();
		private static var currentSortParam:String = "";
		
		// flat data from json
		public static function setData(sourceData:Array):void {
			itemsDictionary = new Dictionary();
			for (var i:int = 0; i < sourceData.length; i++) {
				itemsDictionary[sourceData[i].name] = new Record(sourceData[i].category, sourceData[i].subcategory, sourceData[i].name, sourceData[i].text, sourceData[i].img);
			}
			parseData();
		}
		
		// parse in structure
		public static function parseData(filterStr:String = ""):void {
			categoriesDictionary = new Dictionary();
			for each (var record:Record in itemsDictionary) {
				if (record.name.toLowerCase().indexOf(filterStr.toLowerCase()) != -1) {
					if (!categoriesDictionary[record.category]) {
						categoriesDictionary[record.category] = new Category(record.category);
					}
					
					var cat:Category = categoriesDictionary[record.category];
					var sub:SubCategory = cat.getSubcategoryByName(record.subcategory);
					var item:Item = new Item(record.name, record.text, record.img);
					
					if (sub == null) {
						sub = new SubCategory(record.subcategory);
						cat.addSubcategory(sub);
					}
					sub.addItem(item);
				}
			}
		}
		
		public static function addItem(record:Record):void {
			itemsDictionary[record.name] = record;
			parseData();
		}
		
		public static function removeItem(record:Record):void {
			itemsDictionary[record.name] = null;
			delete itemsDictionary[record.name];
			parseData();
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
		
		public static function getCategories(sortBy:String = ""):Array {
			if (!sortBy) sortBy = currentSortParam;
			var result:Array = [];
			for each (var cat:Category in categoriesDictionary) {
				result.push(cat);
			}
			if (sortBy)	result.sortOn(sortBy);
			currentSortParam = sortBy;
			return result;
		}
		
		public static function getItemByName(name:String):Record {
			return itemsDictionary[name];
		}
	}
}