package ua.com.syo.uitest.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ua.com.syo.uitest.model.DataStorage;
	import ua.com.syo.uitest.model.Record;
	import ua.com.syo.uitest.view.components.Button;
	import ua.com.syo.uitest.view.components.CheckBox;
	import ua.com.syo.uitest.view.components.InputText;
	import ua.com.syo.uitest.view.components.Panel;
	import ua.com.syo.uitest.view.components.TextArea;
	
	public class ArtistsListPageView extends Sprite
	{
		private var imgPanel:Panel;
		private var expandingView:ExpandingListView;
		private var checkBox:CheckBox;
		private var filterIT:InputText;
		private var itemIT:InputText;
		private var textArea:TextArea;
		private var addButton:Button;
		private var removeButton:Button;
		
		public function ArtistsListPageView()
		{
			expandingView = new ExpandingListView(this, 0, 0);
			expandingView.setSize(240, 400);
			expandingView.setData(DataStorage.getCategories());
			expandingView.addEventListener(Event.SELECT, onItemSelected);
			
			var toolsPanel:Panel = new Panel(this, 275, 0);
			toolsPanel.setSize(230, 120);
			
			checkBox = new CheckBox(toolsPanel, 10, 10, "Hide Subcategories", hideSubCheckBoxHandler);
			
			var sortNameButton:Button = new Button(toolsPanel, 10, 30, "Sort By Name", onButtonHandler);
			var sortDateButton:Button = new Button(toolsPanel, 120, 30, "Sort By Date", onButtonHandler);
			
			filterIT = new InputText(toolsPanel, 10, 60, "", onFilterChangeHandler);
			filterIT.setSize(100, 20);
			
			var clearButton:Button = new Button(toolsPanel, 120, 60, "Clear Filter", onButtonHandler);
			
			itemIT = new InputText(toolsPanel, 10, 90, "", onNameChangeHandler);
			itemIT.setSize(100, 20);
			
			addButton = new Button(toolsPanel, 120, 90, "Add", onButtonHandler);
			addButton.setSize(40, 20);
			addButton.enabled = false;
			removeButton = new Button(toolsPanel, 170, 90, "Remove", onButtonHandler);
			removeButton.setSize(50, 20);
			removeButton.enabled = false;
		}
		
		private function hideSubCheckBoxHandler(event:MouseEvent):void {
			expandingView.subcategoryVisible = !checkBox.selected;
			if (!checkBox.selected) {
				expandingView.setData(DataStorage.getCategories());
			}
		}
		
		/**
		 * buttons handler
		 */
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
				case "Add":
					if (expandingView.selectedItem && itemIT.text != "") {
						record = DataStorage.getItemByName(expandingView.selectedItem.name);
						DataStorage.addItem(new Record(record.category, record.subcategory, itemIT.text));
						itemIT.text = "";
						expandingView.setData(DataStorage.getCategories());
						removeButton.enabled = false;
					}
					onNameChangeHandler(null);
					break;
				case "Remove":
					if (expandingView.selectedItem) {
						record = DataStorage.getItemByName(expandingView.selectedItem.name);
						DataStorage.removeItem(new Record(record.category, record.subcategory, record.name));
						expandingView.setData(DataStorage.getCategories());
						removeButton.enabled = false;
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
		
		private function onNameChangeHandler(event:Event):void {
			addButton.enabled = itemIT.text != "" && expandingView.selectedItem;
		}
		
		private function onSortButtonHandler(event:MouseEvent):void {
			DataStorage.parseData(filterIT.text);
			expandingView.setData(DataStorage.getCategories());
		}
		
		private function onItemSelected(event:Event):void {
			removeButton.enabled = true;
			onNameChangeHandler(null);
		}
	}
}