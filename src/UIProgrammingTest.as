package {

	import com.adobe.serialization.json.JSON;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import ua.com.syo.uitest.components.Button;
	import ua.com.syo.uitest.components.CheckBox;
	import ua.com.syo.uitest.components.InputText;
	import ua.com.syo.uitest.components.Panel;
	import ua.com.syo.uitest.components.TextArea;
	import ua.com.syo.uitest.model.DataStorage;
	import ua.com.syo.uitest.model.Item;
	import ua.com.syo.uitest.model.Record;
	import ua.com.syo.uitest.view.ExpandingListView;

	[SWF(frameRate = "60", width = "900", height = "700", backgroundColor = "0xcccccc")]
	public class UIProgrammingTest extends Sprite {

		private var _jsonPath:String = "data/music.json";
		
		private var imgPanel:Panel;
		private var expandingView:ExpandingListView;
		private var checkBox:CheckBox;
		private var filterIT:InputText;
		private var itemIT:InputText;
		private var textArea:TextArea;
		private var addButton:Button;
		private var removeButton:Button;

		public function UIProgrammingTest() {
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(event:Event = null):void {
			this.scaleX = this.scaleY = 1.6;
			stage.quality = StageQuality.HIGH_16X16;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url = _jsonPath;
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(request);
		}


		private function onLoaderComplete(e:Event):void {

			DataStorage.setData(com.adobe.serialization.json.JSON.decode(URLLoader(e.target).data).list);
			showGUI();
		}

		

		private function hideSubCheckBoxHandler(event:MouseEvent):void {
			trace(checkBox.selected);
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
			var item:Item = expandingView.selectedItem;
			textArea.text = item.text;

			var record:Record = DataStorage.getItemByName(item.name);


			if (item.img) {
				qLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnImageLoad);
				qLoader.load(new URLRequest(item.img));
			}
			removeButton.enabled = true;
			onNameChangeHandler(null);
		}
		private var qLoader:Loader = new Loader();

		private function OnImageLoad(e:Event):void {
			var qTempBitmap:Bitmap = qLoader.content as Bitmap;
			var qBitmap:Bitmap = new Bitmap(qTempBitmap.bitmapData);
			imgPanel.addChild(qBitmap);
		}

		private function showGUI():void {

			expandingView = new ExpandingListView(this, 10, 10);
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

			itemIT = new InputText(toolsPanel, 10, 90, "", onNameChangeHandler);
			itemIT.setSize(100, 20);

			addButton = new Button(toolsPanel, 120, 90, "Add", onButtonHandler);
			addButton.setSize(40, 20);
			addButton.enabled = false;
			removeButton = new Button(toolsPanel, 170, 90, "Remove", onButtonHandler);
			removeButton.setSize(50, 20);
			removeButton.enabled = false;

			var contentPanel:Panel = new Panel(this, 280, 170);
			contentPanel.setSize(230, 240);

			imgPanel = new Panel(contentPanel, 10, 10);
			imgPanel.setSize(100, 85);

			textArea = new TextArea(contentPanel, 10, 110);
			textArea.setSize(210, 120);
			textArea.html = true;
		}
	}

}
