package ua.com.syo.uitest.view
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import ua.com.syo.uitest.model.DataStorage;
	import ua.com.syo.uitest.model.Item;
	import ua.com.syo.uitest.model.Record;
	import ua.com.syo.uitest.view.components.Button;
	import ua.com.syo.uitest.view.components.CheckBox;
	import ua.com.syo.uitest.view.components.InputText;
	import ua.com.syo.uitest.view.components.Panel;
	import ua.com.syo.uitest.view.components.TextArea;
	
	public class MotoShopPageView extends Sprite
	{
		
		private var expandingView:ExpandingListView;
		private var contentPanel:Panel;
		private var listContainer:Sprite;
		
		private var itemsDictionary:Dictionary = new Dictionary(true);
		
		public function MotoShopPageView()
		{
			expandingView = new ExpandingListView(this, 0, 0);
			expandingView.multiselect = true;
			expandingView.setSize(240, 400);
			expandingView.setData(DataStorage.getCategories());
			expandingView.addEventListener(Event.SELECT, onItemSelected);
			
			contentPanel = new Panel(this, 260, 0);
			contentPanel.setSize(260, 400);
			listContainer = new Sprite();
			contentPanel.addRawChild(listContainer);
		}
		
		
		
		private function onItemSelected(event:Event):void {
			var item:Item = expandingView.selectedItem;
			
			var record:Record = DataStorage.getItemByName(item.name);
			itemsDictionary[record.subcategory] = item;
			refreshList();
		}
		
		private function refreshList():void {
			while (listContainer.numChildren > 0) {
				listContainer.removeChildAt(0);
			}
			var dy:int = 0;
			for each (var i:Item in itemsDictionary) 
			{
				var shopItem:ShopItemView = new ShopItemView(i);
				listContainer.addChild(shopItem).y = dy;
				dy += 70;
			}
			
		}
		
	}
}