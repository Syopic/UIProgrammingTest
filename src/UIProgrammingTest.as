package {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import ua.com.syo.uitest.components.Accordion;
	import ua.com.syo.uitest.components.ScrollPane;
	import ua.com.syo.uitest.model.Record;
	import ua.com.syo.uitest.view.CategoryView;

	[SWF(frameRate = "60", width = "640", height = "640", backgroundColor = "0xcccccc")]
	public class UIProgrammingTest extends Sprite {
		
		private var _jsonPath:String = "data/music.json";
		private var _records:Vector.<Record> = new Vector.<Record>();
		
		public function UIProgrammingTest() {
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(event:Event = null):void {
			//this.scaleX = this.scaleY = 2;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url = _jsonPath;
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(request);
		}


		private function onLoaderComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			var json:Object = com.adobe.serialization.json.JSON.decode(loader.data);
			var list:Array = json.list;
			for (var i:int = 0; i < list.length; i++) 
			{
				_records.push(new Record(list[i].category, list[i].subcategory, list[i].name));
			}
			showGUI();
		}
		
		private function showGUI():void {
			
			//var panel:ScrollPane = new ScrollPane(this, 10, 10);
			//panel.setSize(200, 350);

			var accordion:Accordion = new Accordion(this, 0, 0);
			accordion.width = 200;


			var category1:CategoryView = new CategoryView(null, 0, 0, "Test Category1", new Array("Item1", "Item2", "Item3", "Item4", "Item3", "Item4"));
			accordion.addCategory(category1, 0);

			var category2:CategoryView = new CategoryView(null, 0, 0, "Test Category2", new Array("Item1", "Item2", "Item3"));
			accordion.addCategory(category2, 1);

			var category3:CategoryView = new CategoryView(null, 0, 0, "Test Category3", new Array("Item1", "Item2"));
			accordion.addCategory(category3, 2);

			var category4:CategoryView = new CategoryView(null, 0, 0, "Test Category4", new Array("Item1", "Item2", "Item3", "Item4", "Item3", "Item4"));
			accordion.addCategory(category4, 3);



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
