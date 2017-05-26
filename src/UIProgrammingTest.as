package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ua.com.syo.uitest.components.Button;
	import ua.com.syo.uitest.components.Label;
	import ua.com.syo.uitest.components.Panel;
	
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
			
			
			var panel:Panel = new Panel(this, 50, 50);
			panel.setSize(200, 400);
			
			var button:Button = new Button(panel, 30, 50, "Button");
			
			var label:Label = new Label(panel, 30, 30, "Hello World!");
			label.text = "This is a label";
		}
	}
}