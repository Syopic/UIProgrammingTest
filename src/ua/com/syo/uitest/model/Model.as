package ua.com.syo.uitest.model
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Model extends EventDispatcher
	{
		private var loader:URLLoader = new URLLoader();
		private var request:URLRequest = new URLRequest();
		
		public function init():void {
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
		}
		
		public function loadData(jsonPath:String):void {
			request.url = jsonPath;
			loader.load(request);
		}
		
		
		private function onLoaderComplete(e:Event):void {
			DataStorage.setData(com.adobe.serialization.json.JSON.decode(URLLoader(e.target).data).list);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Singleton
		 */
		private static var _instance:Model;
		
		public static function get instance():Model {
			if (_instance == null) {
				_instance = new Model();
			}
			return _instance;
		}
	}
}