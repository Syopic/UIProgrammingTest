package {

	import flash.display.Sprite;
	import flash.events.Event;
	
	import ua.com.syo.uitest.controller.Controller;
	import ua.com.syo.uitest.view.UIManager;

	[SWF(frameRate = "60", width = "540", height = "460", backgroundColor = "0xeeeeee")]
	public class UIProgrammingTest extends Sprite {

		public function UIProgrammingTest() {
			if (stage) init();
			 else 
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}

		private function init(event:Event = null):void {
			//this.scaleX = this.scaleY = 1.6;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			UIManager.instance.init(this);
			Controller.instance.init();
		}
	}

}
