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
	import ua.com.syo.uitest.components.ScrollPane;
	import ua.com.syo.uitest.components.Text;
	import ua.com.syo.uitest.components.TextArea;
	import ua.com.syo.uitest.model.DataStorage;
	import ua.com.syo.uitest.model.Item;
	import ua.com.syo.uitest.model.Record;
	import ua.com.syo.uitest.view.ExpandingListView;

	[SWF(frameRate = "60", width = "800", height = "700", backgroundColor = "0xcccccc")]
	public class UIProgrammingTest extends Sprite {

		private var _jsonPath:String = "data/music.json";
		private var componentWidth:int = 250;
		private var componentHeight:int = 400;






		public function UIProgrammingTest() {
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(event:Event = null):void {
			//this.scaleX = this.scaleY = 1.2;
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


		private var imgPanel:Panel;
		private var expandingView:ExpandingListView;
		private var checkBox:CheckBox;
		private var filterIT:InputText;
		private var itemIT:InputText;
		private var textArea:TextArea;

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
					filterIT.text = "";
					onFilterChangeHandler(null);
					break;
				case "Add":
					if (expandingView.selectedItem && itemIT.text != "") {
						record = DataStorage.getItemByName(expandingView.selectedItem.name);
						DataStorage.addItem(new Record(record.category, record.subcategory, itemIT.text));
						itemIT.text = "";
						expandingView.setData(DataStorage.getCategories());
					}
					break;
				case "Remove":
					if (expandingView.selectedItem) {
						record = DataStorage.getItemByName(expandingView.selectedItem.name);
						DataStorage.removeItem(new Record(record.category, record.subcategory, record.name));
						expandingView.setData(DataStorage.getCategories());
					}
					break;

			}
			expandingView.subcategoryVisible = !checkBox.selected;
		}

		private function onFilterChangeHandler(event:Event):void {
			DataStorage.fillData(filterIT.text);
			expandingView.setData(DataStorage.getCategories());
			expandingView.subcategoryVisible = !checkBox.selected;
		}

		private function onSortButtonHandler(event:MouseEvent):void {
			DataStorage.fillData(filterIT.text);
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


			//var button:Button = new Button(

			var toolsPanel:Panel = new Panel(this, 280, 10);
			toolsPanel.setSize(230, 150);

			checkBox = new CheckBox(toolsPanel, 10, 10, "Hide Subcategories", hideSubCheckBoxHandler);

			var sortNameButton:Button = new Button(toolsPanel, 10, 30, "Sort By Name", onButtonHandler);
			var sortDateButton:Button = new Button(toolsPanel, 120, 30, "Sort By Date", onButtonHandler);

			filterIT = new InputText(toolsPanel, 10, 60, "", onFilterChangeHandler);
			filterIT.setSize(100, 20);

			var clearButton:Button = new Button(toolsPanel, 120, 60, "Clear Filter", onButtonHandler);

			itemIT = new InputText(toolsPanel, 10, 90, "");
			itemIT.setSize(100, 20);

			var addButton:Button = new Button(toolsPanel, 120, 90, "Add", onButtonHandler);
			addButton.setSize(40, 20);
			var removeButton:Button = new Button(toolsPanel, 170, 90, "Remove", onButtonHandler);
			removeButton.setSize(50, 20);



			var contentPanel:Panel = new Panel(this, 280, 170);
			contentPanel.setSize(230, 240);

			imgPanel = new Panel(contentPanel, 10, 10);
			imgPanel.setSize(100, 85);

			textArea = new TextArea(contentPanel, 10, 110);
			textArea.setSize(210, 120);
			textArea.html = true;


			const ksXoaXLogo:String = "http://www.xoax.net/public/XoaXLogoNew.png";





		/*
		var category1:CategoryView = new CategoryView(null, 0, 0, "Test Category1", new Array("Item1", "Item2", "Item3", "Item4", "Item3", "Item4"));
		accordion.addCategory(category1, 0);

		var category2:CategoryView = new CategoryView(null, 0, 0, "Test Category2", new Array("Item1", "Item2", "Item3"));
		accordion.addCategory(category2, 1);

		var category3:CategoryView = new CategoryView(null, 0, 0, "Test Category3", new Array("Item1", "Item2"));
		accordion.addCategory(category3, 2);

		var category4:CategoryView = new CategoryView(null, 0, 0, "Test Category4", new Array("Item1", "Item2", "Item3", "Item4", "Item3", "Item4"));
		accordion.addCategory(category4, 3);
		*/


		/*var window:Window = new Window(null, 0, 0, "Test Window");
		//var list:List = new List(window, 0, 0, ["Item1", "Item2", "Item3", "Item4", "Item3", "Item4"]);
		var subCategory:Subcategory = new Subcategory(window, 0, 0);
		subCategory.width = 200;
		accordion.addWindow(window, 0);*/

		/*accordion.addWindowAt("Kyiv", 1);
		accordion.addWindowAt("London", 2);
		accordion.addWindowAt("Harkiv", 3);*/
			//accordion.addWindowAt("Lviv", 3);
			//list.width = width;
			//var window:Window = new Window(panel, 200, 30, "Test Window");
			//var label:Label = new Label(window, 5, 5, "Hello World!");
			//var list:List = new List(window, 0, 0, ["Item1", "Item2", "Item3", "Item4"]);

			//window.addChild(label);


			//var window:Window = new Window(panel, 30, 250, "Test Window");


			//var combobox:ComboBox = new ComboBox(panel, 300, 100, "ComboBox", ["Item1", "Item2", "Item3", "Item4", "Item5", "Item1", "Item2", "Item3", "Item4", "Item5"]);
			//combobox.autoHideScrollBar = false;

		/*for(var i:int = 0; i < 2; i++)
		{
			var window:Window = new Window(_vbox, 0, 0, "Section " + (i + 1));
			window.grips.visible = false;
			window.draggable = false;
			window.addEventListener(Event.SELECT, onWindowSelect);
			if(i != 0) window.minimized = true;
			_windows.push(window);
		}*/


		}
	}

}
