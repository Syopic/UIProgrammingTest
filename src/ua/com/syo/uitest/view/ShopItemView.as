package ua.com.syo.uitest.view
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import ua.com.syo.uitest.model.Item;
	import ua.com.syo.uitest.view.components.Label;
	import ua.com.syo.uitest.view.components.Panel;
	
	public class ShopItemView extends Sprite
	{
		private var imgPanel:Panel;
		private var label:Label;
		private var qLoader:Loader = new Loader();
		
		public function ShopItemView(item:Item)
		{
			imgPanel = new Panel(this, 10, 10);
			imgPanel.setSize(60, 60);
			label = new Label(this, 80, 10, item.name);
			
			if (item.img) {
				qLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnImageLoad);
				qLoader.load(new URLRequest(item.img));
			}
		}
		
		private function OnImageLoad(e:Event):void {
			var qTempBitmap:Bitmap = qLoader.content as Bitmap;
			var qBitmap:Bitmap = new Bitmap(qTempBitmap.bitmapData);
			imgPanel.addChild(qBitmap);
		}
	}
}