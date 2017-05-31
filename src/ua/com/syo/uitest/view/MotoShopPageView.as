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
	
	public class MotoShopPageView extends Sprite
	{
		
		private var imgPanel:Panel;
		private var expandingView:ExpandingListView;
		private var checkBox:CheckBox;
		private var filterIT:InputText;
		private var textArea:TextArea;
		
		private var qLoader:Loader = new Loader();
		
		public function MotoShopPageView()
		{
			expandingView = new ExpandingListView(this, 0, 0);
			expandingView.setSize(240, 400);
			expandingView.setData(DataStorage.getCategories());
			expandingView.addEventListener(Event.SELECT, onItemSelected);
			
			var toolsPanel:Panel = new Panel(this, 280, 10);
			toolsPanel.setSize(230, 150);
			
			checkBox = new CheckBox(toolsPanel, 10, 10, "Hide Subcategories", hideSubCheckBoxHandler);
			
			var sortNameButton:Button = new Button(toolsPanel, 10, 30, "Sort By Name", onButtonHandler);
			var sortDateButton:Button = new Button(toolsPanel, 120, 30, "Sort By Date", onButtonHandler);
			
			filterIT = new InputText(toolsPanel, 10, 60, "", onFilterChangeHandler);
			filterIT.setSize(100, 20);
			
			var clearButton:Button = new Button(toolsPanel, 120, 60, "Clear Filter", onButtonHandler);
			
			var contentPanel:Panel = new Panel(this, 280, 170);
			contentPanel.setSize(230, 240);
			
			imgPanel = new Panel(contentPanel, 10, 10);
			imgPanel.setSize(100, 85);
			
			textArea = new TextArea(contentPanel, 10, 110);
			textArea.setSize(210, 120);
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
			
			
			if (item.img) {
				qLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnImageLoad);
				qLoader.load(new URLRequest(item.img));
			}
		}
		
		
		private function OnImageLoad(e:Event):void {
			var qTempBitmap:Bitmap = qLoader.content as Bitmap;
			var qBitmap:Bitmap = new Bitmap(qTempBitmap.bitmapData);
			imgPanel.addChild(qBitmap);
		}
	}
}