package ua.com.syo.uitest.controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osmf.events.LoadEvent;
	import org.osmf.events.LoaderEvent;
	
	import ua.com.syo.uitest.model.DataStorage;
	import ua.com.syo.uitest.model.Model;
	import ua.com.syo.uitest.view.UIManager;

	public class Controller extends EventDispatcher
	{
		private var jsonData:Array = new Array("data/music.json", "data/music.json", "data/music.json");
		
		private var _currentStageIndex:int = 0;
		
		public function init():void {
			Model.instance.init();
			Model.instance.addEventListener(Event.COMPLETE, loadDataCompleteHandler);
			switchStage(0);
		}
		
		public function switchStage(index:int):void {
			if (index < 0) index = jsonData.length - 1;
			if (index >= jsonData.length) index = 0;
			if (index < jsonData.length)
				Model.instance.loadData(jsonData[index]);
			
			_currentStageIndex = index;
		}
		
		private function loadDataCompleteHandler(event:Event):void {
			UIManager.instance.showStage(currentStageIndex);
		}
		
		public function get currentStageIndex():int {
			return _currentStageIndex;
		}
		
		
		/**
		 * Singleton
		 */
		private static var _instance:Controller;
		
		public static function get instance():Controller {
			if (_instance == null) {
				_instance = new Controller();
			}
			return _instance;
		}
	}
}