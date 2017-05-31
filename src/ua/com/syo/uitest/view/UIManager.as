package ua.com.syo.uitest.view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import ua.com.syo.uitest.controller.Controller;
	import ua.com.syo.uitest.model.Record;
	import ua.com.syo.uitest.view.components.Button;
	import ua.com.syo.uitest.view.components.Label;

	public class UIManager extends EventDispatcher
	{
		private var _parentContainer:DisplayObjectContainer;
		private var _container:DisplayObjectContainer;
		private var artistsPageView:ArtistsListPageView;
		private var motoPageView:MotoShopPageView;
		private var lessonsPageView:LessonsPageView;
		
		private var titles:Array = new Array("1. Artists List", "2. Moto Goods Shop", "3. Lessons List");
		
		
		
		private var prewButton:Button;
		private var nextButton:Button;
		private var titleLabel:Label;
		
		public function init(container:DisplayObjectContainer):void {
			_parentContainer = container; 
			prewButton = new Button(_parentContainer, 10, 10, "Prew", onButtonHandler);
			nextButton = new Button(_parentContainer, 120, 10, "Next", onButtonHandler);
			titleLabel = new Label(_parentContainer, 230, 10);
		}
		
		public function showStage(index:int):void {
			clearStage();
			titleLabel.text = titles[index];
			
			switch (index) {
				case 0:
					if (!artistsPageView) artistsPageView = new ArtistsListPageView();
					_container.addChild(artistsPageView);
					break;
				case 1:
					if (!motoPageView) motoPageView = new MotoShopPageView();
					_container.addChild(motoPageView);
					break;
				case 2:
					if (!lessonsPageView) lessonsPageView = new LessonsPageView();
					_container.addChild(lessonsPageView);
					break;
			}
		}
		
		private function onButtonHandler(event:MouseEvent):void {
			var record:Record;
			switch (event.currentTarget.label) {
				case "Prew":
					Controller.instance.switchStage(Controller.instance.currentStageIndex - 1);
					break;
				case "Next":
					Controller.instance.switchStage(Controller.instance.currentStageIndex + 1);
					break;
			}
		}

		private function clearStage():void {
			if (_container && _parentContainer.contains(_container)) {
				_parentContainer.removeChild(_container);
			}
			_container = new Sprite();
			_container.x = 10;
			_container.y = 50;
			_parentContainer.addChild(_container);
		}
		
		/**
		 * Singleton
		 */
		private static var _instance:UIManager;
		
		public static function get instance():UIManager {
			if (_instance == null) {
				_instance = new UIManager();
			}
			return _instance;
		}
	}
}