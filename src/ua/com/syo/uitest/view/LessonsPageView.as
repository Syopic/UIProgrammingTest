package ua.com.syo.uitest.view
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import ua.com.syo.uitest.model.DataStorage;
	import ua.com.syo.uitest.model.Item;
	import ua.com.syo.uitest.model.Record;
	import ua.com.syo.uitest.view.components.Button;
	import ua.com.syo.uitest.view.components.CheckBox;
	import ua.com.syo.uitest.view.components.InputText;
	import ua.com.syo.uitest.view.components.Panel;
	import ua.com.syo.uitest.view.components.TextArea;
	
	public class LessonsPageView extends Sprite
	{
		private var expandingView:ExpandingListView;
		private var checkBox:CheckBox;
		private var filterIT:InputText;
		private var textArea:TextArea;
		
		private var qLoader:Loader = new Loader();
		
		public function LessonsPageView()
		{
			expandingView = new ExpandingListView(this, 0, 0);
			expandingView.setSize(240, 400);
			expandingView.setData(DataStorage.getCategories("name"));
			expandingView.addEventListener(Event.SELECT, onItemSelected);
			
			textArea = new TextArea(this, 260, 0);
			textArea.setSize(260, 400);
			textArea.html = true;
		}
		
		private function hideSubCheckBoxHandler(event:MouseEvent):void {
			expandingView.subcategoryVisible = !checkBox.selected;
			if (!checkBox.selected) {
				expandingView.setData(DataStorage.getCategories());
			}
		}
		
		private function onButtonHandler(event:MouseEvent):void {
			var record:Record;
			switch (event.currentTarget.label) {
				case "Sort By Name":
					expandingView.setData(DataStorage.getCategories("name"));
					break;
				case "Sort By Date":
					expandingView.setData(DataStorage.getCategories("date"));
					break;
				case "Clear Filter":
					if (filterIT.text != "") {
						filterIT.text = "";
						onFilterChangeHandler(null);
					}
					break;
				
			}
			expandingView.subcategoryVisible = !checkBox.selected;
		}
		
		private function onFilterChangeHandler(event:Event):void {
			DataStorage.parseData(filterIT.text);
			expandingView.setData(DataStorage.getCategories());
			expandingView.subcategoryVisible = !checkBox.selected;
		}
				
		private function onSortButtonHandler(event:MouseEvent):void {
			DataStorage.parseData(filterIT.text);
			expandingView.setData(DataStorage.getCategories());
		}
		
		private function onItemSelected(event:Event):void {
			var item:Item = expandingView.selectedItem;
			textArea.text = item.text;
			
			var record:Record = DataStorage.getItemByName(item.name);
			
		}
	}
}