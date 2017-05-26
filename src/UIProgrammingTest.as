package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ua.com.syo.uitest.components.Accordion;
	import ua.com.syo.uitest.components.Button;
	import ua.com.syo.uitest.components.ComboBox;
	import ua.com.syo.uitest.components.Label;
	import ua.com.syo.uitest.components.Panel;
	import ua.com.syo.uitest.components.ScrollPane;
	import ua.com.syo.uitest.components.Window;
	
	[SWF(frameRate = "60", width = "640", height = "640", backgroundColor = "0xcccccc")]
	public class UIProgrammingTest extends Sprite
	{
		public function UIProgrammingTest()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			var panel:ScrollPane = new ScrollPane(this, 50, 50);
			panel.setSize(500, 500);
			
			var button:Button = new Button(panel, 30, 50, "Button");
			
			
			
			var accordion:Accordion = new Accordion(panel, 30, 100);
			accordion.addWindowAt("Kyiv", 0);
			accordion.addWindowAt("London", 1);
			accordion.addWindowAt("Harkiv", 2);
			accordion.addWindowAt("Lviv", 3);
			var window:Window = accordion.addWindowAt("Odessa", 4);
			window.setSize(100, 200);
			
			var label:Label = new Label(null, 30, 30, "Hello World!");
			
			window.addChild(label);
			
			
			//var window:Window = new Window(panel, 30, 250, "Test Window");
			
			
			var combobox:ComboBox = new ComboBox(panel, 300, 100, "ComboBox", ["Item1", "Item2", "Item3", "Item4", "Item5", "Item1", "Item2", "Item3", "Item4", "Item5"]);
			combobox.autoHideScrollBar = false;
			
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